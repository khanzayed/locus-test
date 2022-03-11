//
//  Weather.swift
//  LocusTest
//
//  Created by Faraz Habib on 11/3/2022.
//

import Foundation


struct Weather: Codable {
    
    let main: String
    let desc: String
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case main, icon
        case desc = "description"
    }
}
