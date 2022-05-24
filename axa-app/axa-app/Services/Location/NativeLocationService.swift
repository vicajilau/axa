//
//  NativeLocationService.swift
//  mobile-universal-architecture-swift
//
//  Created by Victor Carreras on 9/5/22.
//

import Foundation
import AsyncLocationKit

class NativeLocationService: LocationService {
    
    private let asyncLocationManager = AsyncLocationManager()
    
    func localizeUserPosition() async throws -> LocationModel {
        let permission = await self.asyncLocationManager.requestAuthorizationWhenInUse()
        if permission == .authorizedWhenInUse || permission == .authorizedAlways {
            do {
                let locationUpdateEvent = try await asyncLocationManager.requestLocation() //Request user location once
                switch locationUpdateEvent {
                case .didUpdateLocations(let locations):
                    // do something
                    if let location = locations.first {
                        return LocationModel(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    }
                    throw LocationError.failWithDescription(errorMessage: "The received location does not contain a first element")
                case .didFailWith(let error):
                    // do something
                    throw LocationError.failWithDescription(errorMessage: error.localizedDescription)
                case .didPaused, .didResume:
                    throw LocationError.failWithDescription(errorMessage: "The event received in the location service is didPaused or didResume")
                case .none:
                    throw LocationError.failWithDescription(errorMessage: "The event received in the location service is none")
                }
            } catch {
                throw LocationError.failWithDescription(errorMessage: error.localizedDescription)
            }
        } else {
            Utils.print("No permission to localize user: \(permission)")
            throw LocationError.noPermission
        }
    }
}
