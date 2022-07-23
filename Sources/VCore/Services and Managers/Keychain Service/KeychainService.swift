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
    /// Returns `Data` or `KeychainServiceError` from key.
    open class func get(key: String) -> Result<Data, Error> {
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
            return .failure(KeychainServiceError(code: status))
        }
        
        return .success(data)
    }
    
    /// Returns `Optional` `Data` from key.
    open class func get(key: String) -> Data? {
        guard case .success(let data) = get(key: key) else { return nil }
        return data
    }
    
    // MARK: Set
    /// Sets `Data` with key, and returns success, or `KeychainServiceError`.
    @discardableResult
    open class func set(key: String, data: Data?) -> ResultNoSuccess<Error> {
        switch data {
        case nil:
            return delete(key: key)

        case let data?:
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword as String,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]

            let _: OSStatus = SecItemDelete(query as CFDictionary)
            let status: OSStatus = SecItemAdd(query as CFDictionary, nil)
            
            guard status == noErr else {
                return .failure(KeychainServiceError(code: status))
            }
            
            return .success
        }
    }
    
    // MARK: Delete
    /// Deletes `Data` with key, and returns success, or `KeychainServiceError`.
    @discardableResult
    open class func delete(key: String) -> ResultNoSuccess<Error> {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key
        ]

        let status: OSStatus = SecItemDelete(query as CFDictionary)
        
        guard status == noErr else {
            return .failure(KeychainServiceError(code: status))
        }
        
        return .success
    }
    
    // MARK: Subscript
    open class subscript(_ key: String) -> Data? {
        get { Self.get(key: key) }
        set { Self.set(key: key, data: newValue) }
    }
}
