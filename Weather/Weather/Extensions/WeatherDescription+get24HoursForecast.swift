//
//  WeatherDescription+get24HoursForecast.swift
//  Weather
//
//  Created by Maxim Sidorov on 03.09.2020.
//  Copyright © 2020 MS. All rights reserved.
//

import Foundation

typealias ForecastItem = (hour: Int, temperature: Int)

extension WeatherDescription {
    func get24HoursForecast() -> [ForecastItem] {
        var answer: [ForecastItem] = []
        if let forecast = self.forecasts {
            let currentHour = Calendar.current.component(.hour, from: Date())
            for hour in currentHour...23 {
                if let temp = forecast[0].hours?[hour].temp {
                    answer.append(ForecastItem(hour, temp))
                }
            }
            guard currentHour != 0 else { return answer }
            for hour in 0...(currentHour - 1) {
                if let temp = forecast[1].hours?[hour].temp {
                    answer.append(ForecastItem(hour, temp))
                }
            }
        }
        return answer
    }
}
