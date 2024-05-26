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
open class KeychainService {
    // MARK: Properties - Configuration
    /// Configuration.
    open var configuration: KeychainServiceConfiguration

    /// `JSONEncoder`.
    open var jsonEncoder: JSONEncoder

    /// `JSONDecoder`.
    open var jsonDecoder: JSONDecoder

    // MARK: Properties - Singleton
    /// Default instance of `KeychainService`.
    public static let `default`: KeychainService = .init(
        configuration: .default
    )

    // MARK: Initializers
    /// Initializes `KeychainService` with `KeychainServiceConfiguration`.
    public init(
        configuration: KeychainServiceConfiguration,
        jsonEncoder: JSONEncoder = .init(),
        jsonDecoder: JSONDecoder = .init()
    ) {
        self.configuration = configuration
        self.jsonEncoder = jsonEncoder
        self.jsonDecoder = jsonDecoder
    }

    // MARK: Operations
    /// Returns `Data` associated with the key.
    open func get(
        key: String
    ) throws -> Data {
        let query: [String: Any] = configuration.getQuery.build(key: key)

        var valueObject: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &valueObject)

        guard status == noErr else {
            throw KeychainServiceError(.failedToGet) // Nothing should be logged if data simply isn't there
        }

        guard
            let data: Data = valueObject as? Data
        else {
            let fromType: String = .init(describing: type(of: valueObject))
            Logger.keychainService.error("Failed to cast '\(fromType)' to 'Data' in 'KeychainService.get(key:)'")
            throw CastingError(from: fromType, to: "Data")
        }

        return data
    }

    /// Sets `Data` with associated key.
    open func set(
        key: String,
        value: Data
    ) throws {
        try? delete(key: key, logsError: false)

        let query: [String: Any] = configuration.setQuery.build(key: key, value: value)

        let status: OSStatus = SecItemAdd(query as CFDictionary, nil)

        guard status == noErr else {
            Logger.keychainService.error("Failed to set 'Data' with key '\(key)' in 'KeychainService.set(key:value:)': 'OSStatus' '\(status)'")
            throw KeychainServiceError(.failedToSet)
        }
    }

    /// Deletes `Data` associated with the key.
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
            if logsError { Logger.keychainService.error("Failed to delete 'Data' with key '\(key)' in 'KeychainService.delete(key:)': 'OSStatus' '\(status)'") }
            throw KeychainServiceError(.failedToDelete)
        }
    }

    // MARK: Operations - Codable
    /// Returns `Codable` associated with the key.
    open func getCodable<Value>(
        key: String
    ) throws -> Value
        where Value: Decodable
    {
        let data: Data = try get(key: key)

        let value: Value
        do {
            value = try jsonDecoder.decode(Value.self, from: data)

        } catch {
            Logger.keychainService.error("Failed to decode '\(Value.self)' from 'Data` in 'KeychainService.getCodable(key:)': \(error)")
            throw KeychainServiceError(.failedToGet)
        }

        return value
    }

    /// Sets `Codable` with associated key.
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
            Logger.keychainService.error("Failed to encode '\(Value.self)' to 'Data` in 'KeychainService.setCodable(key:value:)': \(error)")
            throw KeychainServiceError(.failedToSet)
        }

        try set(key: key, value: data)
    }

    /// Deletes `Codable` associated with the key.
    open func deleteCodable(
        key: String
    ) throws {
        try delete(key: key)
    }

    // MARK: Subscript
    open subscript(_ key: String) -> Data? {
        get {
            try? get(key: key)
        }
        set {
            if let newValue {
                try? set(key: key, value: newValue)
            } else {
                try? delete(key: key)
            }
        }
    }
}
