//
//  KeychainService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.07.22.
//

import Foundation

// MARK: - Keychain Service
final class KeychainService {
    // MARK: Initializers
    private init() {}
    
    // MARK: Methods
    static func get(key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue as Any,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var valueObject: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &valueObject)

        guard
            status == noErr,
            let data: Data = valueObject as? Data
        else {
            return nil
        }
        
        return data
    }
    
    static func set(key: String, data: Data?) {
        switch data {
        case nil:
            delete(key: key)

        case let data?:
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword as String,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]

            SecItemDelete(query as CFDictionary)
            
            let _: OSStatus = SecItemAdd(query as CFDictionary, nil)
        }
    }
    
    static func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key
        ]

        SecItemDelete(query as CFDictionary)
    }
}
