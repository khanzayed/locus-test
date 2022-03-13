//
//  GeoCodingResponse.swift
//  LocusTest
//
//  Created by Faraz Habib on 12/3/2022.
//

import Foundation

struct GeocodingResponse: Codable {
    
    let coord: GeoCoordinates
    let name: String
    
}
