//
//  KeychainService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.07.22.
//

import Foundation
import OSLog

/// Object that performs get, set, and delete Keychain operations.
///
/// Object contains default instance `default`.
///
/// For error codes, refer to [documentation](https://developer.apple.com/documentation/security/1542001-security_framework_result_codes).
nonisolated open class KeychainService: @unchecked Sendable {
    // MARK: Properties - Singleton
    /// Default instance of `KeychainService` that uses `default` configuration.
    public static let `default`: KeychainService = .init(
        configuration: .default
    )
    
    // MARK: Properties - Configuration
    private var _configuration: KeychainServiceConfiguration
    
    /// Configuration.
    open var configuration: KeychainServiceConfiguration {
        @storageRestrictions(initializes: _configuration)
        init(initialValue) {
            self._configuration = initialValue
        }
        get { queue.sync { _configuration } }
        set { queue.sync(flags: .barrier) { _configuration = newValue } }
    }

    // MARK: Properties - JSON Encoder
    private var _jsonEncoder: JSONEncoder = .init()
    
    /// `JSONEncoder`.
    ///
    /// Used in `Codable` methods.
    open var jsonEncoder: JSONEncoder {
        get { queue.sync { _jsonEncoder } }
        set { queue.sync(flags: .barrier) { _jsonEncoder = newValue } }
    }

    // MARK: Properties - JSON Decoder
    private var _jsonDecoder: JSONDecoder = .init()
    
    /// `JSONDecoder`.
    ///
    /// Used in `Codable` methods.
    open var jsonDecoder: JSONDecoder {
        get { queue.sync { _jsonDecoder } }
        set { queue.sync(flags: .barrier) { _jsonDecoder = newValue } }
    }
    
    // MARK: Properties - Queue
    private let queue: DispatchQueue = .init(
        label: "com.vakhtang-kontridze.vcore.keychain-service",
        attributes: .concurrent
    )

    // MARK: Initializers
    /// Initializes `KeychainService` with `KeychainServiceConfiguration`.
    public init(
        configuration: KeychainServiceConfiguration
    ) {
        self.configuration = configuration
    }

    // MARK: Operations
    /// Returns `Data` associated with the key.
    open func getData(
        key: String
    ) throws -> Data {
        let query: [String: Any] = configuration.getQuery.build(key: key)

        var valueObject: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &valueObject)

        guard status == noErr else {
            throw KeychainServiceError.failedToGet // Error shouldn't be logged if data simply isn't there
        }

        guard
            let data: Data = valueObject as? Data
        else {
            let fromType: AnyObject?.Type = type(of: valueObject)
            Logger.keychainService.error("Failed to cast '\(fromType)' to 'Data' in 'KeychainService.getData(key:)'")
            throw CastingError(from: "\(fromType)", to: "Data")
        }

        return data
    }

    /// Sets `Data` with the key.
    open func setData(
        key: String,
        value: Data
    ) throws {
        // `deleteQuery` is reused here as a lookup query, since it contains only the necessary attributes
        let updateQuery: [String: Any] = configuration.deleteQuery.build(key: key)
        let updateAttributes: [String: Any] = [kSecValueData as String: value]
        let updateStatus: OSStatus = SecItemUpdate(updateQuery as CFDictionary, updateAttributes as CFDictionary)

        // Item existed and was updated successfully
        if updateStatus == noErr {
            return

        // Item doesn't exist, so it will be added
        } else if updateStatus == errSecItemNotFound {
            let setQuery: [String: Any] = configuration.setQuery.build(key: key, value: value)
            let setStatus: OSStatus = SecItemAdd(setQuery as CFDictionary, nil)

            guard setStatus == noErr else {
                Logger.keychainService.error("Failed to set 'Data' with key '\(key)' in 'KeychainService.setData(key:value:)': 'OSStatus' '\(setStatus)'")
                throw KeychainServiceError.failedToSet
            }
            
            return

        // Failed to update item
        } else {
            Logger.keychainService.error("Failed to update 'Data' with key '\(key)' in 'KeychainService.setData(key:value:)': 'OSStatus' '\(updateStatus)'")
            throw KeychainServiceError.failedToSet
        }
    }

    /// Deletes `Data` associated with the key.
    open func deleteData(
        key: String
    ) throws {
        try deleteData(key: key, logsError: true)
    }

    private func deleteData(
        key: String,
        logsError: Bool
    ) throws {
        let query: [String: Any] = configuration.deleteQuery.build(key: key)

        let status: OSStatus = SecItemDelete(query as CFDictionary)

        guard status == noErr else {
            if logsError { Logger.keychainService.error("Failed to delete 'Data' with key '\(key)' in 'KeychainService.delete(key:)': 'OSStatus' '\(status)'") }
            throw KeychainServiceError.failedToDelete
        }
    }

    // MARK: Operations - Codable
    /// Returns `Codable` associated with the key.
    open func getCodable<Value>(
        key: String
    ) throws -> Value
        where Value: Decodable
    {
        let data: Data = try getData(key: key)

        let value: Value
        do {
            value = try jsonDecoder.decode(from: data)

        } catch {
            Logger.keychainService.error("Failed to decode '\(Value.self)' from 'Data' in 'KeychainService.getCodable(key:)': \(error.localizedDescription)")
            throw KeychainServiceError.failedToGet
        }

        return value
    }

    /// Sets `Codable` with the key.
    open func setCodable<Value>(
        key: String,
        value: Value
    ) throws
        where Value: Encodable
    {
        let data: Data
        do {
            data = try jsonEncoder.encode(value)
        } catch {
            Logger.keychainService.error("Failed to encode '\(Value.self)' to 'Data' in 'KeychainService.setCodable(key:value:)': \(error.localizedDescription)")
            throw KeychainServiceError.failedToSet
        }

        try setData(key: key, value: data)
    }

    /// Deletes `Codable` associated with the key.
    open func deleteCodable(
        key: String
    ) throws {
        try deleteData(key: key)
    }

    // MARK: Subscript
    open subscript(_ key: String) -> Data? {
        get {
            try? getData(key: key)
        }
        set {
            if let newValue {
                try? setData(key: key, value: newValue)
            } else {
                try? deleteData(key: key)
            }
        }
    }
}
