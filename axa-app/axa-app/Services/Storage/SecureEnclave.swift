//
//  SecureEncalve.swift
//  mobile-universal-architecture-swift
//
//  Created by Victor Carreras on 5/5/22.
//

import Foundation

class SecureEnclave {
    
    private let keySecureEnclave = "\(Bundle.main.bundleIdentifier!).keys"
    private var key: SecKey {
        if let storedKey = SecureEnclave.loadKey(name: keySecureEnclave) {
            return storedKey
        } else {
            return SecureEnclave.createAndStoreKey(name: keySecureEnclave)
        }
    }
    private var algorithm: SecKeyAlgorithm = .eciesEncryptionCofactorVariableIVX963SHA256AESGCM
    
    private static func createAndStoreKey(name: String, requiresBiometry: Bool = false) -> SecKey {
        
        let flags: SecAccessControlCreateFlags = requiresBiometry ? [.privateKeyUsage, .biometryCurrentSet] : .privateKeyUsage
        
        let access = SecAccessControlCreateWithFlags(kCFAllocatorDefault, kSecAttrAccessibleWhenUnlockedThisDeviceOnly, flags, nil)!
        let tag = name.data(using: .utf8)!
        let attributes: [String: Any] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeEC,
            kSecAttrKeySizeInBits as String: 256,
            kSecAttrTokenID as String: kSecAttrTokenIDSecureEnclave,
            kSecPrivateKeyAttrs as String: [
                kSecAttrIsPermanent as String: true,
                kSecAttrApplicationTag as String: tag,
                kSecAttrAccessControl as String: access
            ]
        ]
        
        var error: Unmanaged<CFError>?
        guard let privateKey = SecKeyCreateRandomKey(attributes as CFDictionary, &error) else {
            preconditionFailure(error!.takeRetainedValue().localizedDescription)
        }
        
        return privateKey
    }
    
    private static func loadKey(name: String) -> SecKey? {
        let tag = name.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: tag,
            kSecAttrKeyType as String: kSecAttrKeyTypeEC,
            kSecReturnRef as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess else {
            return nil
        }
        // swiftlint:disable force_cast
        return (item as! SecKey)
        // swiftlint:enable force_cast
    }
    
}

// MARK: - Public Methods
extension SecureEnclave {
    
    func encrypt(clearText: String) -> Data {
        let clearTextData = clearText.data(using: .utf8)!
        return encrypt(data: clearTextData)
    }
    
    func encrypt(data: Data) -> Data {
        guard let publicKey = SecKeyCopyPublicKey(key) else {
            preconditionFailure("Unable to get public key") // Can't get public key

        }
        
        guard SecKeyIsAlgorithmSupported(publicKey, .encrypt, algorithm) else {
            preconditionFailure("Algorithm does not support in encryption for Secure Enclave")
        }
        var error: Unmanaged<CFError>?
        let cipherTextData = SecKeyCreateEncryptedData(publicKey, algorithm, data as CFData, &error) as Data?
        guard let cipherTextData = cipherTextData else {
            preconditionFailure("Unable to Encrypt Data: \(error.debugDescription)")
        }
        return cipherTextData
    }
    
    func decrypt(cipherTextData: Data?) -> String {
        guard SecKeyIsAlgorithmSupported(key, .decrypt, algorithm) else {
            preconditionFailure("Algorithm does not support in decryption for Secure Enclave")
        }
        
        var error: Unmanaged<CFError>?
        let clearTextData = SecKeyCreateDecryptedData(key, algorithm, cipherTextData! as CFData, &error) as Data?
        guard let clearTextData = clearTextData else {
            preconditionFailure("Unable Decryt Data: \(error.debugDescription)")
        }
        let clearText = String(decoding: clearTextData, as: UTF8.self)
        // clearText is our decrypted string
        return clearText
    }
}
