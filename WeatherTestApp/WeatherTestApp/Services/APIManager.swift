//
//  APIManager.swift
//  WeatherTestApp
//
//  Created by Tomasz Idzi on 16/01/2018.
//  Copyright © 2018 Tomasz Idzi. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SwiftyJSON

class APIManager: NSObject {
    static let baseURL = "http://samples.openweathermap.org/data/2.5/"
    static let appid = "khwbacqbjerov"
    static let alamoManager: Alamofire.SessionManager = Alamofire.SessionManager.default
    
    class func getWeather(completion : @escaping ( _ response : WeatherResponse? , _ error: String?)->()) {
        alamoManager.request(baseURL+"weather?lat=37.785834&lon=62.66"+"&appid="+appid,
                             method: .get,
                             parameters: nil,
                             encoding: JSONEncoding.default,
                             headers: nil)
            .responseJSON(completionHandler: { response in
                switch response.result {
                
                case .success(let data):
                    let json = JSON(data)
                    if let dataJSON  = json.dictionaryObject {
                        let object = WeatherResponse(JSON: dataJSON)
                        completion(object, nil)
                    } else {
                        completion(nil, nil)
                    }
                    
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    completion(nil, error.localizedDescription)
                }
            })
    }
    
    class func getForecast(completion : @escaping ( _ response : ForecastResponse? , _ error: String?)->()) {
        alamoManager.request(baseURL+"forecast/daily?lat=37.785834&lon=62.66&cnt=10&"+"&appid="+appid,
                             method: .get,
                             parameters: nil,
                             encoding: JSONEncoding.default,
                             headers: nil)
            .responseJSON(completionHandler: { response in
                switch response.result {
                    
                case .success(let data):
                    let json = JSON(data)
                    if let dataJSON  = json.dictionaryObject {
                        let object = ForecastResponse(JSON: dataJSON)
                        completion(object, nil)
                    } else {
                        completion(nil, nil)
                    }
                    
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    completion(nil, error.localizedDescription)
                }
            })
    }
}
