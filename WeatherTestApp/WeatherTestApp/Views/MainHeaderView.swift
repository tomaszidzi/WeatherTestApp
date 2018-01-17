//
//  MainHeaderView.swift
//  WeatherTestApp
//
//  Created by Tomasz Idzi on 16/01/2018.
//  Copyright © 2018 Tomasz Idzi. All rights reserved.
//

import UIKit

class MainHeaderView: UIView {

    //MARK: Properties
    @IBOutlet var view: UIView!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descripionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK: Init
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        self.view = Bundle.main.loadNibNamed("MainHeaderView", owner: self, options: nil)?.first as! UIView
        
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth,
                                 UIViewAutoresizing.flexibleHeight]
        view.frame = bounds
        self.addSubview(view)
    }

    //MARK: Functions
    func updateUI(with response: WeatherResponse) {
        if let date = response.timestamp {
            self.dataLabel.text = "Today, " + date.timestampToLongDateString
        }
        
        if let temperature = response.main?.temp {
            self.tempLabel.text = "\(temperature.celsius) °C"
        }
        
        if let descriptionName = response.details?.first?.main {
            self.descripionLabel.text = descriptionName
            self.iconImageView.image = UIImage(named: descriptionName)
        }
        
        self.locationLabel.text = response.city
    }
}
