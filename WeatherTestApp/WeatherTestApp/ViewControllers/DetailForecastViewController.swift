//
//  DetailForecastViewController.swift
//  WeatherTestApp
//
//  Created by Tomasz Idzi on 17/01/2018.
//  Copyright © 2018 Tomasz Idzi. All rights reserved.
//

import UIKit

class DetailForecastViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var morningLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var eveningLabel: UILabel!
    @IBOutlet weak var nightLabel: UILabel!
    
    var forecastDailyWeather: ForecastDailyWeather!
    
    //MARK: Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail Weather"
        updateUI(with: forecastDailyWeather)
    }
    
    //MARK: Functions
    func updateUI(with forecast: ForecastDailyWeather) {
        if let temperature = forecast.temperature {
            self.minLabel.text = temperature.min?.celsiusString
            self.maxLabel.text = temperature.max?.celsiusString
            self.morningLabel.text = temperature.morn?.celsiusString
            self.dayLabel.text = temperature.day?.celsiusString
            self.eveningLabel.text = temperature.eve?.celsiusString
            self.nightLabel.text = temperature.night?.celsiusString
        }
    }
}
