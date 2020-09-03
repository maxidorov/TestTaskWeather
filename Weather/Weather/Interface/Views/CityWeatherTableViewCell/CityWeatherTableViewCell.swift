//
//  CityWeatherTableViewCell.swift
//  Weather
//
//  Created by Maxim Sidorov on 03.09.2020.
//  Copyright © 2020 MS. All rights reserved.
//

import UIKit

class CityWeatherTableViewCell: UITableViewCell {
    
    static public let cellID = "CityWeatherTableViewCell"

    @IBOutlet weak private var cityNameLabel: UILabel! {
        didSet {
            cityNameLabel.font = Brandbook.font(size: 24, weight: .bold)
        }
    }
    
    @IBOutlet weak private var cityWeatherLabel: UILabel! {
        didSet {
            cityWeatherLabel.text = "Loading..."
            cityWeatherLabel.font = Brandbook.font(size: 14, weight: .bold)
            cityWeatherLabel.textColor = .lightGray
        }
    }
    
    @IBOutlet weak private var cityTemperatureLabel: UILabel! {
        didSet {
            cityTemperatureLabel.font = Brandbook.font(size: 30, weight: .bold)
        }
    }
    
    struct CityWeatherCellViewModel {
        let cityName: String
        let cityWeatherDescription: WeatherDescription?
    }
    
    public func update(with viewModel: CityWeatherCellViewModel) {
        cityNameLabel.text = viewModel.cityName
        guard let description = viewModel.cityWeatherDescription else { return }
        cityWeatherLabel.text = description.fact?.condition?.capitalized
        cityTemperatureLabel.text = "\(description.fact?.temp ?? 0)".celsius()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = UITableViewCell.SelectionStyle.none
    }
}
