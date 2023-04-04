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
/// Object contains default instance `default`.
///
/// For error codes, refer to [documentation](https://developer.apple.com/documentation/security/1542001-security_framework_result_codes).
///
///     KeychainService.default.get(key: "SomeKey")
///     KeychainService.default.set(key: "SomeKey", data: data)
///     KeychainService.default.delete(key: "SomeKey")
///
public final class KeychainService {
    // MARK: Properties
    /// Configuration.
    public var configuration: KeychainServiceConfiguration
    
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
    public func get(key: String) throws -> Data {
        let query: [String: Any] = configuration.getQuery.build(key: key)

        var valueObject: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &valueObject)

        guard status == noErr else {
            throw KeychainServiceError(.failedToGet) // No logging should occur if data simply isn't there
        }
        
        guard let data: Data = valueObject as? Data else {
            let error: KeychainServiceError = .init(.failedToCast)
            VCoreLogError(error)
            throw error
        }
        
        return data
    }
    
    // MARK: Set
    /// Sets `Data` with key.
    public func set(key: String, data: Data?) throws {
        switch data {
        case nil:
            try delete(key: key) // Logged internally

        case let data?:
            try? delete(key: key, logsError: false)
            
            let query: [String: Any] = configuration.setQuery.build(key: key, data: data)

            let status: OSStatus = SecItemAdd(query as CFDictionary, nil)
            
            guard status == noErr else {
                let error: KeychainServiceError = .init(.failedToSet)
                VCoreLogError(error, "Security framework error with status code `\(status)`")
                throw error
            }
        }
    }
    
    // MARK: Delete
    /// Deletes `Data` with key.
    public func delete(key: String) throws {
        try delete(key: key, logsError: true)
    }
    
    private func delete(
        key: String,
        logsError: Bool
    ) throws {
        let query: [String: Any] = configuration.deleteQuery.build(key: key)

        let status: OSStatus = SecItemDelete(query as CFDictionary)
        
        guard status == noErr else {
            let error: KeychainServiceError = .init(.failedToDelete)
            if logsError { VCoreLogError(error, "Security framework error with status code `\(status)`") }
            throw error
        }
    }
    
    // MARK: Subscript
    public subscript(_ key: String) -> Data? {
        get { try? get(key: key) } // Logged internally
        set { try? set(key: key, data: newValue) } // Logged internally
    }
}
