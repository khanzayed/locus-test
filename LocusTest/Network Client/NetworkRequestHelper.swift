//
//  NetworkRequestHelper.swift
//  LocusTest
//
//  Created by Faraz Habib on 11/3/2022.
//

import Foundation
import Alamofire

struct NetworkHelper {
   
    // We can configure environments here
    static var baseUrl : String { 
        get {
            return "https://api.openweathermap.org";
        }
    }
    
    static var baseUrlForImageDownload: String {
        get {
            return "https://openweathermap.org"
        }
    }
    
    static var appId : String {
        get {
            return "65d00499677e59496ca2f318eb68c049";
        }
    }
    
    static var headers : HTTPHeaders {
        get {
            let params: [String: String] = [
                "Content-Type"          :   "application/json"
            ]

            return HTTPHeaders(params)
        }
    }
    
    
    static func log(url:String, jsonData:Data?, method: HTTPMethod) {
        var curlString = "THE CURL REQUEST:\n"
        curlString += "curl -X \(method.rawValue) \\\n"
        headers.dictionary.forEach{(key, value) in
            let headerKey = escapeQuotesInString(str: key)
            let headerValue = escapeQuotesInString(str: value)
            curlString += " -H \'\(headerKey): \(headerValue)\' \n"
        }
        
        curlString += " \(url) \\\n"
        
        if let data = jsonData, let str = String(data: data,
                                                 encoding: String.Encoding.utf8) {
            let bodyDataString = escapeQuotesInString(str: str)
            curlString += " -d \'\(bodyDataString)\'"
        }
        
        print(curlString)
    }
    
    static func escapeQuotesInString(str:String) -> String {
        return str.replacingOccurrences(of: "\\", with: "")
    }
    
}
