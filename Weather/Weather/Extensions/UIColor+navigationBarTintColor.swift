//
//  UIColor+navigationBarTintColor.swift
//  Weather
//
//  Created by Maxim Sidorov on 03.09.2020.
//  Copyright © 2020 MS. All rights reserved.
//

import UIKit

extension UIColor {
    static var navigationBarTintColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traits -> UIColor in
                return traits.userInterfaceStyle == .dark ? .white : .black
            }
        } else {
            return .black
        }
    }
}
