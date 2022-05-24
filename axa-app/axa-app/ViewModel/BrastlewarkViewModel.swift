//
//  MainViewModel.swift
//  mobile-universal-architecture-swift
//
//  Created by Victor Carreras on 23/4/22.
//

import UIKit

class BrastlewarkViewModel: BaseViewModel {
    
    @MainActor func getVillagers() async throws -> BrastlewarkModel {
        return try await brastlewarkService.getVillagersInBrastlewark()
    }
    
}
