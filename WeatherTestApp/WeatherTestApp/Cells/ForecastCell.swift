//
//  ForecastCell.swift
//  WeatherTestApp
//
//  Created by Tomasz Idzi on 17/01/2018.
//  Copyright © 2018 Tomasz Idzi. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!

    //MARK: Functions
    func updateUI(with response: ForecastDailyWeather) {
        if let weatherCondition = response.weather?.first?.main {
            self.iconImageView.image = UIImage(named: weatherCondition)
            self.conditionLabel.text = weatherCondition
        }
        
        if let date = response.timestamp {
            self.dayLabel.text = date.timestampToWeekDayString
        }
        
        if let minTemp = response.temperature?.min {
            self.minTempLabel.text = "\(minTemp.celsius) °C"
        }
        
        if let maxTemp = response.temperature?.max {
            self.maxTempLabel.text = "\(maxTemp.celsius) °C"
        }
    }
}
