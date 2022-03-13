//
//  ForecastNetworkClient.swift
//  LocusTest
//
//  Created by Faraz Habib on 11/3/2022.
//

import Foundation
import Alamofire

struct ForecastNetworkClient {
    
    func getGeographicalCoordinates(_ cityName: String, completion: @escaping (GeocodingResponse?, AFError?) -> Void) {
        let url = NetworkHelper.baseUrl + "/data/2.5/weather?q=\(cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&appid=\(NetworkHelper.appId)"
        
        let request = AF.request(url)
        request.responseDecodable(of: GeocodingResponse.self) { (response) in
            switch response.result {
            case .success(_):
                completion(response.value, nil)
            case .failure(_):
                completion(nil, response.error)
            }
        }
        
        NetworkHelper.log(url: url, jsonData: nil, method: .get)
    }

    
    func getHourlyForecastForCity(_ lat: Double, lon: Double, completion: @escaping (Forecast?, AFError?) -> Void) {
        let url = NetworkHelper.baseUrl + "/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,daily,alerts&appid=\(NetworkHelper.appId)"
        
        let request = AF.request(url)
        request.responseDecodable(of: Forecast.self) { (response) in
            switch response.result {
            case .success(_):
                completion(response.value, nil)
            case .failure(_):
                completion(nil, response.error)
            }
        }
        
        NetworkHelper.log(url: url, jsonData: nil, method: .get)
    }
    
    func downloadImage(imageName: String, completion: @escaping (Data?) -> Void) {
        let url = NetworkHelper.baseUrlForImageDownload + "/img/wn/\(imageName)@2x.png"
        let request = AF.request(url)
        request.response { response in

          switch response.result {
           case .success(let responseData):
               completion(responseData)
           case .failure(_):
              completion(nil)
           }
        }
    }
    
}
