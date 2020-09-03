//
//  ViewControllerBuilder.swift
//  Weather
//
//  Created by Maxim Sidorov on 03.09.2020.
//  Copyright © 2020 MS. All rights reserved.
//

import UIKit

class ViewControllerFabric {
    static func buildInitialViewController() -> UINavigationController {
        let citiesListViewController = CitiesListViewController()
        let weatherNetworkManager = WeatherNetworkingManager()
        weatherNetworkManager.reachabilityManager = ReachabilityManager()
        citiesListViewController.weatherNetworkManager = weatherNetworkManager
        return UINavigationController(rootViewController: citiesListViewController)
    }
}
