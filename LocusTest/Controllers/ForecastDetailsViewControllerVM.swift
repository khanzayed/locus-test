//
//  ForecastDetailsViewControllerVM.swift
//  LocusTest
//
//  Created by Faraz Habib on 13/3/2022.
//

import Foundation

class ForecastDetailsViewControllerVM {
    
    var forecastData: ForecastData!
    
    var city: String {
        get {
            return cityName
        }
    }
    
    var temp: String {
        get {
            return forecastData.temp.displayCelciusWithUnit
        }
    }

    var weather: String {
        get {
            return "\(forecastData.weather[0].main)"
        }
    }
    
    var weatherImageName: String? {
        get {
            return forecastData.weather[0].icon
        }
    }
    
    var humidity: String {
        get {
            if let value = forecastData.humidity {
                return "\(value) %"
            }
            
            return "--"
        }
    }
    
    var pressure: String {
        get {
            if let value = forecastData.pressure {
                return "\(value) hPA"
            }
            
            return "--"
        }
    }
    
    var windSpeed: String {
        get {
            if let value = forecastData.windSpeed {
                return "\(value) m/s"
            }
            
            return "--"
        }
    }
    
    var dayString: String {
        get {
            
            let date = Date(timeIntervalSince1970: forecastData.timeInterval)
            
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US")
            formatter.dateFormat = "dd MMM"
            return formatter.string(from: date)
        }
    }
    
    var dateString: String {
        get {
            
            let date = Date(timeIntervalSince1970: forecastData.timeInterval)
            
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US")
            formatter.dateFormat = "hh a"
            return formatter.string(from: date)
        }
    }
    
    init(forecastData: ForecastData) {
        self.forecastData = forecastData
    }
    
    func downloadImage(imageName: String, completion: @escaping (Data?) -> Void) {
        ForecastNetworkClient().downloadImage(imageName: imageName) { [weak self] data in
            guard let _ = self else { return }
            
            completion(data)
        }
    }
    
}
