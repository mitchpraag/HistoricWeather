//
//  WeatherController.swift
//  WeatherAppVersion2
//
//  Created by Mitch Praag on 8/17/17.
//  Copyright © 2017 Mitch Praag. All rights reserved.
//

import Foundation
import CoreLocation


struct WeatherController {
    
    static func fetchWeather(at zipCode: String, at date: Date, completion: @escaping ((WeatherModel?) -> Void)) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(zipCode) { (placemarks :[CLPlacemark]?, error: Error?) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let placemarks = placemarks,
                let firstPlacemark = placemarks.first,
                let location = firstPlacemark.location
                else { completion(nil); return }
            
            let longitude = location.coordinate.longitude
            let latitude = location.coordinate.latitude
            let unixTime = date.timeIntervalSince1970
            let key = "436e6a9a5a397e175397f1ccd2e1a207"
            let timeString = String(format: "%.0f", unixTime)
            
            var baseURLstring = "https://api.darksky.net/forecast/"
            baseURLstring.append(key)
            baseURLstring.append("/")
            baseURLstring.append("\(latitude)")
            baseURLstring.append(",")
            baseURLstring.append("\(longitude)")
            baseURLstring.append(",")
            baseURLstring.append("\(unixTime)")
            print(baseURLstring)
            
            
            guard let url = URL(string: baseURLstring) else { completion(nil); return }
            let defaultSession = URLSession.shared
            
            let task = defaultSession.dataTask(with: url, completionHandler: { (data: Data?, urlResponse: URLResponse?, error: Error?) in
                
                guard let data = data,
                    let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String : Any],
                    let weather = WeatherModel(jsonResponse: jsonDictionary) else { completion(nil); return }
                
                completion(weather)
            })
            
            task.resume()
        }
        
    }
}
