//
//  ViewController.swift
//  Weather
//
//  Created by Maxim Sidorov on 03.09.2020.
//  Copyright © 2020 MS. All rights reserved.
//

import UIKit

class CitiesListViewController: UIViewController {
    
    var weatherNetworkManager: IWeatherNetworkingManager!
    
    private var searchBar: UISearchBar!
    private var tableView: UITableView!
    
    private var weatherDescription: [String: WeatherDescription] = [:] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var citiesNamesToLocations: [String: Location] {
        return CitiesDataProvider.citiesNamesToLocations
    }
    
    private var citiesNames: [String] {
        return citiesNamesToLocations.map { $0.key } .sorted()
    }
    
    private var filteredCitiesNames: [String] {
        guard let searchBarText = searchBar.text, searchBarText != "" else { return citiesNames }
        return citiesNames.filter { $0.lowercased().contains(searchBarText.lowercased()) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSearchBar()
        setupTableView()
        loadWeatherDescription()
    }
    
    private func loadWeatherDescription() {
        for city in citiesNames {
            weatherNetworkManager.getWeatherIn(city: city) { [weak self] result in
                switch result {
                case .success(let description):
                    DispatchQueue.main.async {
                        self?.weatherDescription[city] = description
                    }
                case .failure(let error):
                    // так как точно знаем в чем ошибка, можем ее правильно отработать, но в качестве примера
                    // будем предполагать, что ошибка в отсутствии интернета
                    print(error)
                    DispatchQueue.main.async { [weak self] in
                        let alert = UIAlertController.noConnection()
                        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: {(alert: UIAlertAction!) in
                            self?.loadWeatherDescription()
                        }))
                        self?.present(alert, animated: true)
                    }
                }
            }
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.placeholder = "Search city"
        searchBar.keyboardType = .default
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.fill(view)
        tableView.register(UINib(nibName: CellsNames.cityWeather.rawValue, bundle: nil), forCellReuseIdentifier: CityWeatherTableViewCell.cellID)
    }
    
    private func pushCityWeatherDetailedViewController(for city: String) {
        let cityWeatherDetailedViewController = CityWeatherDetailedViewController()
        cityWeatherDetailedViewController.weatherDescription = weatherDescription[city]
        cityWeatherDetailedViewController.weatherNetworkingManager = weatherNetworkManager
        cityWeatherDetailedViewController.title = city
        navigationController?.pushViewController(cityWeatherDetailedViewController, animated: true)
    }
}

extension CitiesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCitiesNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityWeatherTableViewCell.cellID, for: indexPath) as! CityWeatherTableViewCell
        let cityName = filteredCitiesNames[indexPath.row]
        let cityWeatherDescription = weatherDescription[cityName]
        cell.update(with: CityWeatherTableViewCell.CityWeatherCellViewModel(cityName: cityName, cityWeatherDescription: cityWeatherDescription))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityName = filteredCitiesNames[indexPath.row]
        pushCityWeatherDetailedViewController(for: cityName)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

extension CitiesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
