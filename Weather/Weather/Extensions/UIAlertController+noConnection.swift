//
//  UIAlertController+noConnection.swift
//  Weather
//
//  Created by Maxim Sidorov on 03.09.2020.
//  Copyright © 2020 MS. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func noConnection() -> Self {
        return UIAlertController(title: "No Connection", message: "Check your Internet connection", preferredStyle: .alert) as! Self
    }
}
