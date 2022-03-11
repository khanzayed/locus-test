//
//  CityViewControllerVM.swift
//  LocusTest
//
//  Created by Faraz Habib on 11/3/2022.
//

import Foundation

protocol CityViewControllerVMDelegate {
    
    func didLoadForecastData()
    func didFailedToLoadForecastData()
    
}

class CityViewControllerVM {
    
    var forecastClient: ForecastNetworkClient!
    var delegate: CityViewControllerVMDelegate!
    
    var forecast: Forecast?
    
    init(forecastClient: ForecastNetworkClient, delegate: CityViewControllerVMDelegate) {
        self.forecastClient = forecastClient
        self.delegate = delegate
    }
    
    
    func getForecastData(cityName: String) {
        forecastClient.getGeographicalCoordinates(cityName) { [weak self] (data, error) in
            guard let this = self else { return }
            
            if let _ = error {
                this.forecast = nil
                this.delegate.didFailedToLoadForecastData()
            } else {
                this.forecastClient.getHourlyForecastForCity(data!.coord.lat, lon: data!.coord.lon, completion: { (forecast, error) in
                    if let _ = error {
                        this.forecast = nil
                        this.delegate.didFailedToLoadForecastData()
                    } else {
                        this.forecast = forecast
                        this.delegate.didLoadForecastData()
                    }
                })
            }
        }
    }
    
}
