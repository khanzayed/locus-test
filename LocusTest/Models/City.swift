//
//  City.swift
//  LocusTest
//
//  Created by Faraz Habib on 11/3/2022.
//

import Foundation
import MapKit

struct City {

    let name: String?
    let state: String?
    let country: String?
    let location: CLLocation?

}

extension City {
    
    func getAddress() -> String? {
        var address = state ?? ""
        if address.isEmpty {
            address = country ?? ""
        } else if let country {
            address += ", " + country
        }
        
        return address
    }
    
}
