//
//  NetworkingHelper.swift
//  Weather
//
//  Created by Maxim Sidorov on 03.09.2020.
//  Copyright © 2020 MS. All rights reserved.
//

import Foundation
import SystemConfiguration

class NetworkingHelper {
    static func buildWeatherURLFromLocation(_ location: Location) -> String {
        let latitude = location.latitude
        let longitude = location.longitude
        return "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)&extra=true"
        // Можно через  QueryItems, но раз других запросов не будет, оставил так
    }
}
