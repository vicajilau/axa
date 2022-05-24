//
//  UrlService.swift
//  mobile-universal-architecture-swift
//
//  Created by Victor Carreras on 23/4/22.
//

import Foundation

class UrlService {
    
    private static let baseUrl = "https://raw.githubusercontent.com"
    
    static func villagersInBrastlewark() -> URL {
        return URL(string: "\(baseUrl)/rrafols/mobile_test/master/data.json")!
    }
}
