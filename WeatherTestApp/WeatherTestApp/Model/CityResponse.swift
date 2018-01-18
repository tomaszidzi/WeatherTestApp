//
//  CityResponse.swift
//  WeatherTestApp
//
//  Created by Tomasz Idzi on 18/01/2018.
//  Copyright © 2018 Tomasz Idzi. All rights reserved.
//

import UIKit
import ObjectMapper

class CityResponse: Mappable {
    var cities: [City]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        cities     <- map["list"]
    }
}

struct City: Mappable {
    var name: String?
    var coordinates: Coordinates?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name        <- map["name"]
        coordinates <- map["coord"]
    }
}
