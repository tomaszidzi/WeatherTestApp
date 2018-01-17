//
//  Extensions.swift
//  WeatherTestApp
//
//  Created by Tomasz Idzi on 17/01/2018.
//  Copyright © 2018 Tomasz Idzi. All rights reserved.
//

import Foundation

extension Double {
    var celsius : Double {
        return (self - 273.15).rounded()
    }
    
    var timestampToLongDateString : String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = NSLocale.current
        return dateFormatter.string(from: date)
    }
    
    var timestampToWeekDayString : String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "EEEE"
        return dateFormatter.string(from: date)
    }
}

