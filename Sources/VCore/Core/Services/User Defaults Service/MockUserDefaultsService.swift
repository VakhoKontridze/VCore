//
//  MockUserDefaultsService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28/5/26.
//

#if DEBUG

import Foundation

/// Object that performs get, set, and delete `UserDefaults` operations.
nonisolated open class MockUserDefaultsService: UserDefaultsService, @unchecked Sendable {
    // MARK: Initializers
    /// Initializes `MockUserDefaultsService`.
    public init() {}
    
    // MARK: Operations
    /// Returns object associated with the key.
    open func get<Value>(
        key: String
    ) throws -> Value {
        throw UserDefaultsServiceError.mockFailedToGet
    }

    /// Sets object with the key.
    open func set<Value>(
        key: String,
        value: Value
    ) {}

    /// Deletes object associated with the key.
    open func delete(
        key: String
    ) {}

    // MARK: Operations - Raw Representable
    /// Returns `RawRepresentable` associated with the key.
    open func getRawRepresentable<Value>(
        key: String
    ) throws -> Value
        where Value: RawRepresentable
    {
        throw UserDefaultsServiceError.mockFailedToGet
    }

    /// Sets `RawRepresentable` with the key.
    open func setRawRepresentable<Value>(
        key: String,
        value: Value
    )
        where Value: RawRepresentable
    {}

    /// Deletes `RawRepresentable` associated with the key.
    open func deleteRawRepresentable(
        key: String
    ) {}

    // MARK: Operations - Codable
    /// Returns `Codable` associated with the key.
    open func getCodable<Value>(
        key: String
    ) throws -> Value
        where Value: Decodable
    {
        throw UserDefaultsServiceError.mockFailedToGet
    }

    /// Sets `Codable` with the key.
    open func setCodable<Value>(
        key: String,
        value: Value
    ) throws
        where Value: Encodable
    {}

    /// Deletes `Codable` associated with the key.
    open func deleteCodable(
        key: String
    ) {}
}

#endif
