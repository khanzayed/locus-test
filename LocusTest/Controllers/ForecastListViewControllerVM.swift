//
//  ForecastListViewControllerVM.swift
//  LocusTest
//
//  Created by Faraz Habib on 12/3/2022.
//

import Foundation


class ForecastListViewControllerVM {
    
    var forecast: Forecast!
    
    var temp: String {
        get {
            return forecast.current.temp.displayCelciusWithUnit
        }
    }

    var weather: String {
        get {
            return "\(forecast.current.weather[0].main)"
        }
    }
    
    var weatherImageName: String? {
        get {
            return forecast.current.weather[0].icon
        }
    }
    
    var humidity: String {
        get {
            if let value = forecast.current.humidity {
                return "\(value) %"
            }
            
            return "--"
        }
    }
    
    var pressure: String {
        get {
            if let value = forecast.current.pressure {
                return "\(value) hPA"
            }
            
            return "--"
        }
    }
    
    var windSpeed: String {
        get {
            if let value = forecast.current.windSpeed {
                return "\(value) m/s"
            }
            
            return "--"
        }
    }
    
    init(forecast: Forecast) {
        self.forecast = forecast
    }
    
    func downloadImage(imageName: String, completion: @escaping (Data?) -> Void) {
        ForecastNetworkClient().downloadImage(imageName: imageName) { [weak self] data in
            guard let _ = self else { return }
            
            completion(data)
        }
    }
    
}
