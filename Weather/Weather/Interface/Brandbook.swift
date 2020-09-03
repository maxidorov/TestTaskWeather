//
//  Brandbook.swift
//  Weather
//
//  Created by Maxim Sidorov on 03.09.2020.
//  Copyright © 2020 MS. All rights reserved.
//

import UIKit

final class Brandbook {
    
    enum Weight: String {
        case thin = "Thin"
        case regular = "Regular"
        case bold = "Bold"
        case medium = "Medium"
        case heavy = "Heavy"
    }
    
    static func font(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
}
