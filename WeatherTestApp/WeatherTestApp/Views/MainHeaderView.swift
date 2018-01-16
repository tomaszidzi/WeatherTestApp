//
//  MainHeaderView.swift
//  WeatherTestApp
//
//  Created by Tomasz Idzi on 16/01/2018.
//  Copyright © 2018 Tomasz Idzi. All rights reserved.
//

import UIKit

class MainHeaderView: UIView {

    @IBOutlet var view: UIView!
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descripionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
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

    func updateUI(with response: WeatherResponse) {
        self.dataLabel.text = "Today, \(String(describing: response.timestamp))"
        self.tempLabel.text = "\(response.main?.temp)"
        self.locationLabel.text = response.city
        self.descripionLabel.text = response.details?.first?.main
    }
}
