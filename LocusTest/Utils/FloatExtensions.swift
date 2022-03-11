//
//  FloatExtensions.swift
//  LocusTest
//
//  Created by Faraz Habib on 12/3/2022.
//

import Foundation


extension Float {
    
    var displayCelciusWithUnit: String {
        let value = String(format: "%.1f", (self - 273.15))
        return "\(value) \u{00B0}C"
    }
    
    var displayCelcius: String {
        let value = String(format: "%.1f", (self - 273.15))
        return value
    }
    
    var displayFloat: String {
        return "\(self) \u{00B0}F"
    }
    
}
