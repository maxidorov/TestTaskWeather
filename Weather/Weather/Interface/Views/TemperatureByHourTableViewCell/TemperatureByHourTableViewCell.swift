//
//  TemperatureByHourTableViewCell.swift
//  Weather
//
//  Created by Maxim Sidorov on 03.09.2020.
//  Copyright © 2020 MS. All rights reserved.
//

import UIKit

class TemperatureByHourTableViewCell: UITableViewCell {
    
    static public var cellID = "TemperatureByHourTableViewCell"
    
    @IBOutlet weak private var hourLabel: UILabel! {
        didSet {
            hourLabel.font = Brandbook.font(size: 18, weight: .bold)
            hourLabel.textColor = .lightGray
        }
    }
    
    @IBOutlet weak private var temperatureLabel: UILabel! {
        didSet {
            temperatureLabel.font = Brandbook.font(size: 20, weight: .bold)
        }
    }
    
    struct TemperatureByHourCellViewModel {
        let hour: Int
        let temperature: Int
    }
    
    public func update(with viewModel: TemperatureByHourCellViewModel) {
        hourLabel.text = "\(viewModel.hour)".hours()
        temperatureLabel.text = "\(viewModel.temperature)".celsius()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = UITableViewCell.SelectionStyle.none
    }
}
