//
//  ViewController.swift
//  WeatherTestApp
//
//  Created by Tomasz Idzi on 16/01/2018.
//  Copyright © 2018 Tomasz Idzi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        APIManager.getWeather() { (response, error) in
            
        }
        
        APIManager.getForecast() { (response, error) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
