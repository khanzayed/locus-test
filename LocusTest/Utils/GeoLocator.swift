//
//  GeoLocator.swift
//  LocusTest
//
//  Created by Faraz Habib on 3/5/2023.
//

import Foundation
import MapKit

struct GeoLocator {
    
    private let geocoder = CLGeocoder()
    
    func getCityDetails(cityName: String,
                        completionHandler: @escaping([City]?, Error?) -> Void) {
        geocoder.cancelGeocode()
        geocoder.geocodeAddressString(cityName) { (placemarks, error) in
            if error == nil {
                let cities = placemarks?.map({ City.init(name: $0.locality,
                                                         state: $0.administrativeArea,
                                                         country: $0.country,
                                                         location: $0.location) })
                completionHandler(cities, nil)
                
                return
            }
            
            completionHandler(nil, error)
        }
    }
    
}
