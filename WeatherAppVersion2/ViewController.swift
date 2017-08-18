//
//  ViewController.swift
//  WeatherAppVersion2
//
//  Created by Mitch Praag on 8/17/17.
//  Copyright © 2017 Mitch Praag. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var insertZipCodeField: UITextField!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBAction func GetWeatherButtonTapped(_ sender: Any) {
        let zip = insertZipCodeField.text ?? ""
        
        WeatherController.fetchWeather(at: zip, at: DatePicker.date) { (weather: WeatherModel?) in
            DispatchQueue.main.async {
                if weather == nil {
                    print("NIL")
                }
            }
            self.updateViews(with: weather)
        }
    }
    @IBOutlet weak var TempLabel: UILabel!
    @IBOutlet weak var IconLabel: UILabel!
    @IBOutlet weak var weatherSummaryLabel: UILabel!
    
    
    func updateViews(with weather: WeatherModel?) {
        if let weather = weather {
            IconLabel.text = weather.iconName
            weatherSummaryLabel.text = weather.summary
            
            
            let formatter = MeasurementFormatter()
            formatter.locale = Locale.current
            formatter.unitStyle = .medium
            TempLabel.text = formatter.string(from: weather.temp)
        } else {
            IconLabel.text = ""
            weatherSummaryLabel.text = ""
            TempLabel.text = ""
            
            
            
        }
        
    }
}
