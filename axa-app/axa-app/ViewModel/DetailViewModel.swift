//
//  DetailViewModel.swift
//  axxa-app
//
//  Created by Victor Carreras on 24/5/22.
//

import Foundation
import UIKit

class DetailViewModel {
    
    private let villager: VillagerModel
    
    init(villager: VillagerModel) {
        self.villager = villager
    }
    
    func getImageURL() -> URL? {
        return URL(string: villager.thumbnail)
    }
    
    func getName() -> String {
        return villager.name
    }
    
    func getYears() -> String {
        return "\(villager.age) years"
    }
    
    func getWeight() -> String {
        return (villager.weight.toStringWith(decimals: 2))
    }
    
    func getHeight() -> String {
        return (villager.height.toStringWith(decimals: 2))
    }
    
    func getHairColor() -> String {
        return villager.hairColor
    }
    
    func getProfessions() -> [String] {
        return villager.professions
    }
    
    func getFriends() -> [String] {
        return villager.friends
    }
}
