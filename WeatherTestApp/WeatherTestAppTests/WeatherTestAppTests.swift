//
//  WeatherTestAppTests.swift
//  WeatherTestAppTests
//
//  Created by Tomasz Idzi on 17/01/2018.
//  Copyright © 2018 Tomasz Idzi. All rights reserved.
//

import XCTest
@testable import WeatherTestApp

class WeatherTestAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testKelvinToCelsiusRoundedCalculation() {
        let kelvinTemperature: Double = 285.51
        let celsiusTemperature = kelvinTemperature.celsius
        XCTAssertEqual(celsiusTemperature, 12.0, "Celsius value is wrong.")
    }
    
    func testKelvinToCelsiusRoundedString() {
        let kelvinTemperature: Double = 285.51
        let celsiusTemperatureStr = kelvinTemperature.celsiusString
        XCTAssertEqual(celsiusTemperatureStr, "12.0 °C", "Celsius value string is wrong.")
    }
    
    func testTimestampToLongString() {
        let timestamp: Double = 1516207120
        let dateString = timestamp.timestampToLongDateString
        XCTAssertEqual(dateString, "January 17, 2018", "The date string is wrong.")
    }
    
    func testTimestampToWeekDayString() {
        let timestamp: Double = 1516207120
        let weekDayString = timestamp.timestampToWeekDayString
        XCTAssertEqual(weekDayString, "Wednesday", "The week day string is wrong.")
    }
    
    func testValidCallToWebServiceGetWeather() {
        let expect = expectation(description: "Get response from web service getWeather method.")
        
        APIManager.getWeather() { (response, error) in
            if (response != nil) {
                expect.fulfill()
            } else {
                XCTFail("Connection to web service failed.")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testValidCallToWebServiceGetForecast() {
        let expect = expectation(description: "Get response from web service getForecast method.")
        
        APIManager.getForecast() { (response, error) in
            if (response != nil) {
                expect.fulfill()
            } else {
                XCTFail("Connection to web service failed.")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
