//
//  ForecastTableViewCellVM.swift
//  LocusTest
//
//  Created by Faraz Habib on 12/3/2022.
//

import Foundation

class ForecastTableViewCellVM {
    
    var temp: String!
    var day: String!
    var dateString: String!
    var weather: String!
    
    init(forcastData: ForecastData) {
        temp = "\(forcastData.temp.displayCelciusWithUnit)"
        weather = "\(forcastData.weather[0].main)"
        
        let date = Date(timeIntervalSince1970: forcastData.timeInterval)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd"
        dateString = formatter.string(from: date)
        
        formatter.dateFormat = "hh a"
        day = formatter.string(from: date)
    }
    
}
