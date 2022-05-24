//
//  LocationModel.swift
//  axxa-app
//
//  Created by Victor Carreras on 24/5/22.
//

import Foundation

struct LocationModel: CustomStringConvertible {
    
    let latitude: Double
    let longitude: Double
    
    var description: String {
        return "Location (latitude: \(latitude), longitude: \(longitude))"
    }
}
