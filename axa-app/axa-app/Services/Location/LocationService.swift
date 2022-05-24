//
//  LocationService.swift
//  mobile-universal-architecture-swift
//
//  Created by Victor Carreras on 23/4/22.
//

import Foundation
import AsyncLocationKit

enum LocationError: Error {
    case noPermission
    case failWithDescription(errorMessage: String)
}

protocol LocationService {
    func localizeUserPosition() async throws -> LocationModel
}
