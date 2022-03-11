//
//  City.swift
//  LocusTest
//
//  Created by Faraz Habib on 11/3/2022.
//

import Foundation

struct City: Codable {
    
    let id: Int64
    let name: String
    let coord: GeoCoordinates
    let country: String
    let sunrise: TimeInterval
    let sunset: TimeInterval
    
}
