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
    var imageName: String?
    
    init(forcastData: ForecastData) {
        imageName = forcastData.weather[0].icon
        
        temp = "\(forcastData.temp.displayCelciusWithUnit)"
        weather = "\(forcastData.weather[0].main)"
        
        let date = Date(timeIntervalSince1970: forcastData.timeInterval)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        formatter.locale = Locale(identifier: "en_US")
        dateString = formatter.string(from: date)
        
        formatter.dateFormat = "hh a"
        day = formatter.string(from: date)
    }
 
    func downloadImage(completion: @escaping (Data?) -> Void) {
        guard let imageName = imageName else {
            completion(nil)
            return
        }
        
        ForecastNetworkClient().downloadImage(imageName: imageName) { [weak self] data in
            guard let _ = self else { return }
            
            completion(data)
        }
    }
}
