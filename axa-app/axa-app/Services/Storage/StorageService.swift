//
//  DataPersistenceService.swift
//  mobile-universal-architecture-swift
//
//  Created by Victor Carreras on 5/5/22.
//

import Foundation

enum StorageKey: String {
    case example // TODO: Remove this case and add each item you need to save to data persistence
}

protocol StorageService {
    func set(value: Any, key: StorageKey)
    func getString(key: StorageKey) -> String
    func getBool(key: StorageKey) -> Bool
    func getInteger(key: StorageKey) -> Int
    func getDouble(key: StorageKey) -> Double
    func getStringList(key: StorageKey) -> [String]
    func remove(key: StorageKey)
}
