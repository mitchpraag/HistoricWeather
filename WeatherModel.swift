//
//  WeatherModel.swift
//  WeatherAppVersion2
//
//  Created by Mitch Praag on 8/17/17.
//  Copyright © 2017 Mitch Praag. All rights reserved.
//

import Foundation
struct WeatherModel {
    
    var iconName: String
    var summary: String
    var temp: Measurement<UnitTemperature>
    
    init?(jsonResponse: [String: Any]) {
        
        
        guard let hourlyDictionary = jsonResponse["hourly"] as? [String : Any],
            let hourlyDataArray = hourlyDictionary["data"] as? [[String : Any]],
            
            let summary = hourlyDictionary["summary"] as? String,
            let iconString = weatherData["icon"] as? String,
            
            let weatherData = hourlyDataArray.first,
            let tempDouble = weatherData["temperature"] as? Double else { return nil }
        
        self.iconName = iconString
        self.summary = summary
        self.temp = Measurement(value: tempDouble, unit: UnitTemperature.fahrenheit)
        
        
        
        
        
    }
}
