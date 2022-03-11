//
//  Forecast.swift
//  LocusTest
//
//  Created by Faraz Habib on 11/3/2022.
//

import Foundation

struct ForecastData: Codable {
    
    let timeInterval: TimeInterval
    let temp: Float
    let feelsLike: Float?
    let pressure: Float?
    let humidity: Float?
    let visibility: Float?
    let windSpeed: Float?
    let windDeg: Float?
    let windGust: Float?
    let weather: [Weather]
    
    
    enum CodingKeys: String, CodingKey {
        case timeInterval = "dt"
        case feelsLike = "feels_like"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case temp, pressure, humidity, weather, visibility
    }
    
}
