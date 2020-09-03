//
//  CityWeatherDetailedViewController.swift
//  Weather
//
//  Created by Maxim Sidorov on 03.09.2020.
//  Copyright © 2020 MS. All rights reserved.
//

import UIKit

class CityWeatherDetailedViewController: UIViewController {
    
    var weatherDescription: WeatherDescription!
    var weatherNetworkingManager: IWeatherNetworkingManager!
    
    private var forecastBy24Hours: [ForecastItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        checkWeatherDescription()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .navigationBarTintColor
    }
    
    private func checkWeatherDescription() {
        guard weatherDescription == nil else {
            forecastBy24Hours = weatherDescription.get24HoursForecast()
            return
        }
        weatherNetworkingManager.getWeatherIn(city: title) { result in
            switch result {
            case .success(let description):
                DispatchQueue.main.async { [weak self] in
                    self?.weatherDescription = description
                    self?.forecastBy24Hours = description.get24HoursForecast()
                }
            case .failure(let error):
                // так как точно знаем в чем ошибка, можем ее правильно отработать, но в качестве примера
                // будем предполагать, что ошибка в отсутствии интернета
                print(error)
                DispatchQueue.main.async { [weak self] in
                    let alert = UIAlertController.noConnection()
                    alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: {(alert: UIAlertAction!) in
                        self?.checkWeatherDescription()
                    }))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.fill(view)
        tableView.register(UINib(nibName: CellsNames.temperatureByHour.rawValue, bundle: nil), forCellReuseIdentifier: TemperatureByHourTableViewCell.cellID)
    }
}


extension CityWeatherDetailedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecastBy24Hours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TemperatureByHourTableViewCell.cellID, for: indexPath) as! TemperatureByHourTableViewCell
        let hour = forecastBy24Hours[indexPath.row].hour
        let temperature = forecastBy24Hours[indexPath.row].temperature
        let viewModel = TemperatureByHourTableViewCell.TemperatureByHourCellViewModel(hour: hour, temperature: temperature)
        cell.update(with: viewModel)
        return cell
    }
}
