//
//  UserDefaultsService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 08.09.24.
//

import Foundation
import OSLog

// MARK: - User Defaults Service
/// Service object that performs get, set, and delete `UserDefaults` operations.
///
/// Object contains default instance `default`.
open class UserDefaultsService {
    // MARK: Properties - Configuration
    /// `UserDefaults` store.
    open var userDefaults: UserDefaults

    /// `JSONEncoder`.
    ///
    /// Used in `Codable` methods.
    open lazy var jsonEncoder: JSONEncoder = .init()
    
    /// `JSONDecoder`.
    ///
    /// Used in `Codable` methods.
    open lazy var jsonDecoder: JSONDecoder = .init()

    // MARK: Properties - Singleton
    /// Default instance of `UserDefaultsService` that uses `standard` `UserDefaults`.
    public static let `default`: UserDefaultsService = .init(
        userDefaults: .standard
    )

    // MARK: Initializers
    /// Initializes `UserDefaultsService` with `UserDefaults`.
    public init(
        userDefaults: UserDefaults
    ) {
        self.userDefaults = userDefaults
    }

    // MARK: Operations
    /// Returns object associated with the key.
    open func get<Value>(
        key: String
    ) throws -> Value {
        guard
            let valueAny: Any = userDefaults.object(forKey: key)
        else {
            throw UserDefaultsServiceError(.failedToGet) // Error shouldn't be logged if data simply isn't there
        }

        guard
            let value: Value = valueAny as? Value
        else {
            let fromType: any Any.Type = type(of: valueAny)
            Logger.userDefaultsService.error("Failed to cast '\(fromType)' to '\(Value.self)' in 'UserDefaultsService.get(key:)'")
            throw CastingError(from: "\(fromType)", to: "\(Value.self)")
        }

        return value
    }

    /// Sets object with the key.
    open func set<Value>(
        key: String,
        value: Value
    ) {
        userDefaults.set(value, forKey: key)
    }

    /// Deletes object associated with the key.
    open func delete(
        key: String
    ) {
        userDefaults.removeObject(forKey: key)
    }

    // MARK: Operations - Raw Representable
    /// Returns `RawRepresentable` associated with the key.
    open func getRawRepresentable<Value>(
        key: String
    ) throws -> Value
        where Value: RawRepresentable
    {
        let rawValue: Value.RawValue = try get(key: key)

        guard
            let value: Value = .init(rawValue: rawValue)
        else {
            Logger.userDefaultsService.error("Failed to initialize '\(Value.self)' with 'rawValue' '\(String(describing: rawValue))' in 'UserDefaultsService.getRawRepresentable(key:)'")
            throw UserDefaultsServiceError(.failedToGet)
        }

        return value
    }

    /// Sets `RawRepresentable` with the key.
    open func setRawRepresentable<Value>(
        key: String,
        value: Value
    )
        where Value: RawRepresentable
    {
        set(key: key, value: value.rawValue)
    }

    /// Deletes `RawRepresentable` associated with the key.
    open func deleteRawRepresentable(
        key: String
    ) {
        delete(key: key)
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
            Logger.keychainService.error("Failed to decode '\(Value.self)' from 'Data` in 'UserDefaultsService.getCodable(key:)': \(error)")
            throw UserDefaultsServiceError(.failedToGet)
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
            Logger.keychainService.error("Failed to encode '\(Value.self)' to 'Data` in 'UserDefaultsService.setCodable(key:value:)': \(error)")
            throw UserDefaultsServiceError(.failedToSet)
        }

        set(key: key, value: data)
    }

    /// Deletes `Codable` associated with the key.
    open func deleteCodable(
        key: String
    ) {
        delete(key: key)
    }
}
