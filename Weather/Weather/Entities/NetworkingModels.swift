//
//  NetworkingModels.swift
//  Weather
//
//  Created by Maxim Sidorov on 03.09.2020.
//  Copyright © 2020 MS. All rights reserved.
//

import Foundation

struct Fact: Decodable {
    var temp: Int?
    var condition: String?
}

struct InfoByHour: Decodable {
    var hour: String?
    var temp: Int?
}

struct Forecast: Decodable {
    var hours: [InfoByHour]?
}

struct WeatherDescription: Decodable {
    var fact: Fact?
    var forecasts: [Forecast]?
}
