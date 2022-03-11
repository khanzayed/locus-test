//
//  Weather.swift
//  LocusTest
//
//  Created by Faraz Habib on 11/3/2022.
//

import Foundation

struct Forecast: Codable {
    
    let lat: Double
    let lon: Double
    let current: ForecastData
    let hourly: [ForecastData]
    
}
