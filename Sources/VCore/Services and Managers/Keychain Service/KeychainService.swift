//
//  KeychainService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.07.22.
//

import Foundation

// MARK: - Keychain Service
/// Service objects that performs `Data` get, set, and delete operations to keychain.
///
/// For error codes, refer to [documentation](https://developer.apple.com/documentation/security/1542001-security_framework_result_codes).
open class KeychainService {
    // MARK: Initializers
    private init() {}
    
    // MARK: Get
    /// Returns `Data` from key.
    open class func get(key: String) throws -> Data {
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
            throw KeychainServiceError.failedToGet
        }
        
        return data
    }
    
    // MARK: Set
    /// Sets `Data` with key, and returns success, or `KeychainServiceError`.
    open class func set(key: String, data: Data?) throws {
        switch data {
        case nil:
            try delete(key: key)

        case let data?:
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword as String,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]

            let _: OSStatus = SecItemDelete(query as CFDictionary)
            let status: OSStatus = SecItemAdd(query as CFDictionary, nil)
            
            guard status == noErr else { throw KeychainServiceError.failedToSet }
        }
    }
    
    // MARK: Delete
    /// Deletes `Data` with key, and returns success, or `KeychainServiceError`.
    open class func delete(key: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key
        ]

        let status: OSStatus = SecItemDelete(query as CFDictionary)
        
        guard status == noErr else { throw KeychainServiceError.failedToDelete }
    }
    
    // MARK: Subscript
    open class subscript(_ key: String) -> Data? {
        get { try? Self.get(key: key) }
        set { try? Self.set(key: key, data: newValue) }
    }
}