//
//  KeychainService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.07.22.
//

import Foundation
import OSLog

// MARK: - Keychain Service
/// Service objects that performs `Data` get, set, and delete operations to keychain.
///
/// Object contains default instance `default`.
///
/// For error codes, refer to [documentation](https://developer.apple.com/documentation/security/1542001-security_framework_result_codes).
///
///     KeychainService.default.get(key: "SomeKey")
///     KeychainService.default.set(key: "SomeKey", data: data)
///     KeychainService.default.delete(key: "SomeKey")
///
open class KeychainService {
    // MARK: Properties
    /// Configuration.
    open var configuration: KeychainServiceConfiguration
    
    /// Default instance of KeychainService.
    ///
    /// `default` instance is used as `KeychainServiceConfiguration`.
    public static let `default`: KeychainService = .init(configuration: .default)
    
    // MARK: Initializers
    /// Initializes `KeychainService` with `KeychainServiceConfiguration`.
    public init(configuration: KeychainServiceConfiguration) {
        self.configuration = configuration
    }
    
    // MARK: Get
    /// Returns `Data` from key.
    open func get(key: String) throws -> Data {
        let query: [String: Any] = configuration.getQuery.build(key: key)
        
        var valueObject: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &valueObject)
        
        guard status == noErr else {
            throw KeychainServiceError(.failedToGet) // No logging should occur if data simply isn't there
        }
        
        guard let data: Data = valueObject as? Data else {
            throw CastingError(from: String(describing: type(of: valueObject)), to: "Data")
        }
        
        return data
    }
    
    // MARK: Set
    /// Sets `Data` with key.
    open func set(key: String, data: Data?) throws {
        switch data {
        case nil:
            try delete(key: key)
            
        case let data?:
            try? delete(key: key, logsError: false)

            let query: [String: Any] = configuration.setQuery.build(key: key, data: data)
            
            let status: OSStatus = SecItemAdd(query as CFDictionary, nil)
            
            guard status == noErr else {
                Logger.keychainService.error("Failed to set 'Data' with key '\(key)' with 'OSStatus' '\(status)' in 'KeychainService.set(key:data:)'")
                throw KeychainServiceError(.failedToSet)
            }
        }
    }
    
    // MARK: Delete
    /// Deletes `Data` with key.
    open func delete(
        key: String
    ) throws {
        try delete(key: key, logsError: true)
    }

    private func delete(
        key: String,
        logsError: Bool
    ) throws {
        let query: [String: Any] = configuration.deleteQuery.build(key: key)

        let status: OSStatus = SecItemDelete(query as CFDictionary)

        guard status == noErr else {
            if logsError { Logger.keychainService.error("Failed to set 'Data' with key '\(key)' with 'OSStatus' '\(status)' in 'KeychainService.delete(key:)'") }
            throw KeychainServiceError(.failedToDelete)
        }
    }

    // MARK: Subscript
    open subscript(_ key: String) -> Data? {
        get { try? get(key: key) }
        set { try? set(key: key, data: newValue) }
    }
}
