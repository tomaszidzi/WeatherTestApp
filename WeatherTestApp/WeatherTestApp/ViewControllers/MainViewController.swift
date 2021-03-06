//
//  ViewController.swift
//  WeatherTestApp
//
//  Created by Tomasz Idzi on 16/01/2018.
//  Copyright © 2018 Tomasz Idzi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var headerView: MainHeaderView!
    @IBOutlet weak var forecastTableView: UITableView!
    
    var forecastResponse: ForecastResponse?
    
    //MARK: Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather App"
        updateWeatherFor(latitude: 54.372158, longitude: 18.638306)
    }
    
    //segue OpenDetailView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ForecastDetailView",
            let destination = segue.destination as? DetailForecastViewController {
            if let cell = sender as? ForecastCell,
                let indexPath = forecastTableView.indexPath(for: cell) {
                let detail = self.forecastResponse?.details![indexPath.row]
                destination.forecastDailyWeather = detail
                forecastTableView.deselectRow(at: indexPath, animated: true)
            }
        } else if segue.identifier == "SearchCityView" {
            if let destination = segue.destination as? SearchCityViewController {
                destination.delegate = self
            }
        }
    }
    
    // MARK: - Private instance methods
    func updateWeatherFor(latitude: Double, longitude: Double) {
        APIManager.getWeatherFor(latitude: latitude, longitude: longitude) { (response, error) in
            if let weatherResponse = response {
                self.headerView.updateUI(with: weatherResponse)
            }
        }
        
        APIManager.getForecastFor(latitude: latitude, longitude: longitude) { (response, error) in
            if let forecastDailyResponse = response {
                self.forecastResponse = forecastDailyResponse
                self.forecastTableView.reloadData()
            }
        }
    }
}

//MARK: TableView
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let detail = self.forecastResponse?.details {
            return detail.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ForecastCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ForecastCell  else {
            fatalError("The dequeued cell is not an instance of ForecastCell.")
        }
        
        if let detail = self.forecastResponse?.details {
            cell.updateUI(with: detail[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }
}

//MARK: SearchCityDelegate
extension MainViewController: SearchCityDelegate {
    
    func weatherWasSelected(for city: City) {
        if let lat = city.coordinates?.latitude,
            let lon = city.coordinates?.longitude {
            updateWeatherFor(latitude: lat, longitude: lon)
        }
    }
}

