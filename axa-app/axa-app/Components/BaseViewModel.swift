//
//  BaseViewModel.swift
//  mobile-universal-architecture-swift
//
//  Created by Victor Carreras on 23/4/22.
//

import UIKit


class BaseViewModel {
    
    let locationService: LocationService = DI.singleton.getDependency(service: LocationService.self)
    let networkService: NetworkService = DI.singleton.getDependency(service: NetworkService.self)
    let brastlewarkService: BrastlewarkService = DI.singleton.getDependency(service: BrastlewarkService.self)
    let persistantService: StorageService = DI.singleton.getDependency(service: StorageService.self)
    
}
