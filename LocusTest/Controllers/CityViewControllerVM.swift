//
//  CityViewControllerVM.swift
//  LocusTest
//
//  Created by Faraz Habib on 11/3/2022.
//

import Foundation

protocol CityViewControllerVMDelegate {
    
    func didLoadForecastData()
    func didFailedToLoadForecastData(message: String)
    
}

class CityViewControllerVM {
    
    var forecastClient: ForecastNetworkClient!
    var delegate: CityViewControllerVMDelegate!
    
    var forecast: Forecast?
    
    var searchedCities: [GeocodingResponse] {
        get {
            if let data = UserDefaults.standard.object(forKey: Keys.kSearchedCities) as? Data {
                let list = try? JSONDecoder().decode([GeocodingResponse].self, from: data)
                return list ?? []
            }
            
            return []
        }
    }
    
    init(forecastClient: ForecastNetworkClient, delegate: CityViewControllerVMDelegate) {
        self.forecastClient = forecastClient
        self.delegate = delegate
    }
    
    private func saveSearchedCity(response: GeocodingResponse) {
        var list = searchedCities
        if let index = searchedCities.firstIndex(where: { $0.name == response.name }) {
            list.remove(at: index)
        } else {
            if list.count >= 5 {
                list.remove(at: list.count - 1)
            }
        }
        
        list.insert(response, at: 0)
        
        if let encoded = try? JSONEncoder().encode(list) {
            UserDefaults.standard.set(encoded, forKey: Keys.kSearchedCities)
        }
    }
    
    
    func getForecastData(searchedText: String) {
        forecastClient.getGeographicalCoordinates(searchedText) { [weak self] (data, error) in
            guard let this = self else { return }
            
            guard let data = data  else {
                this.forecast = nil
                this.delegate.didFailedToLoadForecastData(message: "Failed to fetch city coordinates details.")
                
                return
            }
            
            if let _ = data.coord {
                this.saveSearchedCity(response: data)
                this.fetchWeatherForecastFromCoordinates(data: data)
            } else {
                this.forecast = nil
                this.delegate.didFailedToLoadForecastData(message: data.message ?? "Failed to fetch city coordinates details.")
            }
        }
    }
    
    func fetchWeatherForecastFromCoordinates(data: GeocodingResponse) {
        cityName = data.name!
        self.forecastClient.getHourlyForecastForCity(data.coord!.lat, lon: data.coord!.lon, completion: { [weak self] (forecast, error) in
            guard let this = self else { return }
            
            if let _ = error {
                this.forecast = nil
                this.delegate.didFailedToLoadForecastData(message: "Failed to fetch city forecast details.")
            } else {
                this.forecast = forecast
                this.delegate.didLoadForecastData()
            }
        })
    }
    
}
