//
//  WeatherResponse.swift
//  WeatherTestApp
//
//  Created by Tomasz Idzi on 16/01/2018.
//  Copyright © 2018 Tomasz Idzi. All rights reserved.
//

import UIKit
import ObjectMapper

class WeatherResponse: Mappable {
    var base: String?
    var id: Int?
    var timestamp: Double?
    var statusCode: Int?
    var city: String?
    var main: MainWeather?
    var coordinates: Coordinates?
    var details: [DetailWeather]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        base        <- map["base"]
        id          <- map["id"]
        timestamp   <- map["dt"]
        statusCode  <- map["cod"]
        city        <- map["name"]
        main        <- map["main"]
        coordinates <- map["coord"]
        details     <- map["weather"]
    }
}

struct MainWeather: Mappable {
    
    var humidity: Int?
    var tempMin: Double?
    var tempMax: Double?
    var temp: Double?
    var pressure: Double?
    var seaLevel: Double?
    var grndLevel: Double?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        humidity     <- map["humidity"]
        tempMin      <- map["temp_min"]
        tempMax      <- map["temp_max"]
        temp         <- map["temp"]
        pressure     <- map["pressure"]
        seaLevel     <- map["sea_level"]
        grndLevel    <- map["grnd_level"]
    }
}

struct Coordinates: Mappable {
    
    var latitude: Double?
    var longitude: Double?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        latitude    <- map["lat"]
        longitude   <- map["lon"]
    }
}

struct DetailWeather: Mappable {
    
    var id: Int?
    var main: String?
    var icon: String?
    var description: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        main        <- map["main"]
        icon        <- map["icon"]
        description <- map["description"]
    }
}
