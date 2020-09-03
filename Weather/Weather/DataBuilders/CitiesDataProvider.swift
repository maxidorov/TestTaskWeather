//
//  CitiesDataBuilder.swift
//  Weather
//
//  Created by Maxim Sidorov on 03.09.2020.
//  Copyright © 2020 MS. All rights reserved.
//

import UIKit

typealias Location = (latitude: Double, longitude: Double)

class CitiesDataProvider {
    static var citiesNamesToLocations: [String: Location] = [
        "Moscow": (55.833333, 37.616667),
        "Saint-Petersburg": (56.3457, 18.9521),
        "Yekaterinburg": (56.838002, 160.597295),
        "Ivanovo": (57.000348, 40.973921),
        "Kaliningrad": (55.916229, 37.854467),
        "Orel": (52.970306, 36.063514),
        "Sochi": (43.581509, 39.722882),
        "Ulan-Ude": (51.833507, 107.584125),
        "Yakutsk": (62.027833, 18.9521),
        "Kostroma": (57.767683, 40.926418)
    ]
}
