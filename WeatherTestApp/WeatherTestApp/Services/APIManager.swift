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
    static let baseURL = "http://api.openweathermap.org/data/2.5/"
    static let appid = "b84b45b6073a2e320877439b7da5e85d"
    static let alamoManager: Alamofire.SessionManager = Alamofire.SessionManager.default
    
    class func getWeatherFor(latitude:Double, longitude:Double, completion: @escaping ( _ response: WeatherResponse? , _ error: String?)->()) {
        alamoManager.request(baseURL+"weather?lat=\(latitude)&lon=\(longitude)"+"&appid="+appid,
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
    
    class func getForecastFor(latitude:Double, longitude:Double, completion: @escaping ( _ response: ForecastResponse? , _ error: String?)->()) {
        alamoManager.request(baseURL+"forecast/daily?lat=\(latitude)&lon=\(longitude)&cnt=10&"+"&appid="+appid,
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
    
    class func getCities(completion: @escaping ( _ response: CityResponse? , _ error: String?)->()) {
        if let url = Bundle.main.url(forResource: "cityList", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let json = JSON(data)
                if let dataJSON  = json.dictionaryObject {
                    let object = CityResponse(JSON: dataJSON)
                    object?.cities = object?.cities?.sorted(by:{$0.name! < $1.name!})
                    completion(object, nil)
                } else {
                   completion(nil, nil)
                }
                
            } catch {
                print("Request failed with error:\(error)")
                completion(nil, error.localizedDescription)
            }
        }
    }
}
