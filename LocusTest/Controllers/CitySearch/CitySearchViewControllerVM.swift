//
//  CityViewControllerVM.swift
//  LocusTest
//
//  Created by Faraz Habib on 11/3/2022.
//

import Foundation

protocol CitySearchViewModel {
 
    var places: [City] { get }
    func searchCities(cityName: String)
        
}

protocol CitySearchDelegate {
    
    func didSearchCities()
        
}

class CitySearchViewControllerVM: CitySearchViewModel {
    
    var geoLocator: GeoLocator!
    var delegate: CitySearchDelegate?
    var places: [City]
    
    init(delegate: CitySearchDelegate?) {
        self.geoLocator = GeoLocator()
        self.delegate = delegate
        self.places = []
    }
    
    func searchCities(cityName: String) {
        geoLocator.getCityDetails(cityName: cityName) { [weak self] (places, error) in
            guard let this = self else { return}
            
            this.places = places ?? []
            this.delegate?.didSearchCities()
        }
    }
    
}
