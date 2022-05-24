//
//  Villager.swift
//  axxa-app
//
//  Created by Victor Carreras on 24/5/22.
//

import Foundation

struct VillagerModel: Decodable {
    let id: Int
    let name: String
    let thumbnail: String
    let age: Int
    let weight: Double
    let height: Double
    let hairColor: String
    let professions: [String]
    let friends: [String]
}
