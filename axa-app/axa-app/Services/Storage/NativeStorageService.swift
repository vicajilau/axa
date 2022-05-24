//
//  NativeStorageService.swift
//  mobile-universal-architecture-swift
//
//  Created by Victor Carreras on 9/5/22.
//

import Foundation

class NativeStorageService: StorageService {
    
    let secureEnclave = SecureEnclave()

    func set(value: Any, key: StorageKey) {
        if isSecureStorage(key: key) {
            saveInSecureStorage(value: value, key: key.rawValue)
        } else {
            saveInUserDefaults(value: value, key: key.rawValue)
        }
    }

    func remove(key: StorageKey) {
        deleteInUserDefaults(key: key.rawValue)
    }

    func getString(key: StorageKey) -> String {
        if isSecureStorage(key: key) {
            return getStringInSecureStorage(key: key.rawValue)
        } else {
            return getStringInUserDefaults(key: key.rawValue)
        }
    }
    
    func getBool(key: StorageKey) -> Bool {
        if isSecureStorage(key: key) {
            return getBoolInSecureStorage(key: key.rawValue)
        } else {
            return getBoolInUserDefaults(key: key.rawValue)
        }
    }
    
    func getInteger(key: StorageKey) -> Int {
        if isSecureStorage(key: key) {
            return getIntInSecureStorage(key: key.rawValue)
        } else {
            return getIntInUserDefaults(key: key.rawValue)
        }
    }
    
    func getDouble(key: StorageKey) -> Double {
        if isSecureStorage(key: key) {
            return getDoubleInSecureStorage(key: key.rawValue)
        } else {
            return getDoubleInUserDefaults(key: key.rawValue)
        }
    }
    
    func getStringList(key: StorageKey) -> [String] {
        if isSecureStorage(key: key) {
            Utils.controlledFailure(message: "There is not function to get array in secureStorage keyChain.")
        } else {
            return getArrayInUserDefaults(key: key.rawValue) ?? [String]()
        }
    }
}

extension NativeStorageService {
    private func isSecureStorage(key: StorageKey) -> Bool {
        return false // TODO: Add the keys that should use the secure enclave
    }
    
    private func saveInUserDefaults(value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    private func saveInSecureStorage(value: Any, key: String) {
        let encryptedData: Data
        if let data: String = value as? String {
            encryptedData = secureEnclave.encrypt(clearText: data)
        } else if let data: Bool = value as? Bool {
            encryptedData = secureEnclave.encrypt(clearText: data.description)
        } else if let data: Data = value as? Data {
            encryptedData = secureEnclave.encrypt(data: data)
        } else if let data: Data = value as? Data {
            encryptedData = secureEnclave.encrypt(data: data)
        } else if let data: Data = value as? Data {
            encryptedData = secureEnclave.encrypt(data: data)
        } else {
            Utils.controlledFailure(message: "Data type has not been implemented in secure storage yet.")
        }
        saveInUserDefaults(value: encryptedData, key: key)
    }
    
    private func deleteInUserDefaults(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    private func getStringInUserDefaults(key: String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
    
    private func getBoolInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    private func getIntInUserDefaults(key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
    
    private func getDoubleInUserDefaults(key: String) -> Double {
        return UserDefaults.standard.double(forKey: key)
    }
    
    private func getArrayInUserDefaults(key: String) -> [String]? {
        return UserDefaults.standard.array(forKey: key) as? [String]
    }
    
    private func getStringInSecureStorage(key: String) -> String {
        if let valueFromUserDefault = UserDefaults.standard.data(forKey: key) {
            return secureEnclave.decrypt(cipherTextData: valueFromUserDefault)
        }
        return ""
    }
    
    private func getBoolInSecureStorage(key: String) -> Bool {
        if let valueFromUserDefault = UserDefaults.standard.data(forKey: key) {
            return secureEnclave.decrypt(cipherTextData: valueFromUserDefault).toBool() ?? false
        }
        return false
    }
    
    private func getDoubleInSecureStorage(key: String) -> Double {
        if let valueFromUserDefault = UserDefaults.standard.data(forKey: key) {
            return secureEnclave.decrypt(cipherTextData: valueFromUserDefault).toDouble() ?? 0
        }
        return 0
    }
    
    private func getIntInSecureStorage(key: String) -> Int {
        if let valueFromUserDefault = UserDefaults.standard.data(forKey: key) {
            return secureEnclave.decrypt(cipherTextData: valueFromUserDefault).toInt() ?? 0
        }
        return 0
    }
}


