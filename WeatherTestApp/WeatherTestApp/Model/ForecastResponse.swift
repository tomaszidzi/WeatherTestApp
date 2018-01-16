//
//  ForecastResponse.swift
//  WeatherTestApp
//
//  Created by Tomasz Idzi on 16/01/2018.
//  Copyright © 2018 Tomasz Idzi. All rights reserved.
//

import UIKit
import ObjectMapper

class ForecastResponse: Mappable {
    var details: [ForecastDailyWeather]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        details     <- map["list"]
    }
}

struct ForecastDailyWeather: Mappable {
    
    var timestamp: Int?
    var speed: Double?
    var humidity: Int?
    var clouds: Int?
    var pressure: Double?
    var deg: Int?
    var weather: [DetailWeather]?
    var temperature: TemperatureWeather?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        timestamp   <- map["dt"]
        speed       <- map["speed"]
        humidity    <- map["humidity"]
        clouds      <- map["clouds"]
        pressure    <- map["pressure"]
        deg         <- map["deg"]
        weather     <- map["weather"]
        temperature <- map["temp"]
    }
}

struct TemperatureWeather : Mappable {
    var night : Double?
    var min : Double?
    var eve : Double?
    var day : Double?
    var max : Double?
    var morn : Double?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        night   <- map["night"]
        min     <- map["min"]
        eve     <- map["eve"]
        day     <- map["day"]
        max     <- map["max"]
        morn    <- map["morn"]
    }
}
