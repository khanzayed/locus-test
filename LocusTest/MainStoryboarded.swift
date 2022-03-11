//
//  MainStoryboarded.swift
//  LocusTest
//
//  Created by Faraz Habib on 11/3/2022.
//

import UIKit

protocol MainStoryboarded {
    
    static func instantiate() -> Self
    
}

extension MainStoryboarded {
    
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboad = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboad.instantiateViewController(withIdentifier: id) as! Self
    }
    
}
