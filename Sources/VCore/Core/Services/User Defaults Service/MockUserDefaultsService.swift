//
//  MockUserDefaultsService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28/5/26.
//

public import Foundation

/// Object that performs get, set, and delete `UserDefaults` operations.
nonisolated open class MockUserDefaultsService: UserDefaultsService, @unchecked Sendable {
    // MARK: Properties - Storage
    private var storage: [String: Any] = [:]

    // MARK: Properties - JSON Encoder
    /// `JSONEncoder`.
    ///
    /// Used in `Codable` methods.
    open var jsonEncoder: JSONEncoder {
        get { queue.sync { _jsonEncoder } }
        set { queue.sync(flags: .barrier) { _jsonEncoder = newValue } }
    }
    private var _jsonEncoder: JSONEncoder = .init()

    // MARK: Properties - JSON Decoder
    /// `JSONDecoder`.
    ///
    /// Used in `Codable` methods.
    open var jsonDecoder: JSONDecoder {
        get { queue.sync { _jsonDecoder } }
        set { queue.sync(flags: .barrier) { _jsonDecoder = newValue } }
    }
    private var _jsonDecoder: JSONDecoder = .init()
    
    // MARK: Properties - Queue
    private let queue: DispatchQueue = .init(
        label: "com.vakhtang-kontridze.vcore.mock-user-defaults-service",
        attributes: .concurrent
    )
    
    // MARK: Initializers
    /// Initializes `MockUserDefaultsService`.
    public init() {}
    
    // MARK: Operations
    /// Returns object associated with the key.
    open func get<Value>(
        key: String
    ) throws -> Value {
        try queue.sync {
            try _get(
                key: key
            )
        }
    }
    
    private func _get<Value>(
        key: String
    ) throws -> Value {
        guard
            let valueAny: Any = storage[key]
        else {
            throw UserDefaultsServiceError.failedToGet
        }

        guard
            let value: Value = valueAny as? Value
        else {
            throw CastingError(from: "\(type(of: valueAny))", to: "\(Value.self)")
        }

        return value
    }

    /// Sets object with the key.
    open func set<Value>(
        key: String,
        value: Value
    ) {
        queue.sync(flags: .barrier) {
            storage[key] = value
        }
    }

    /// Deletes object associated with the key.
    open func delete(
        key: String
    ) {
        _ = queue.sync(flags: .barrier) {
            storage.removeValue(forKey: key)
        }
    }

    // MARK: Operations - Raw Representable
    /// Returns `RawRepresentable` associated with the key.
    open func getRawRepresentable<Value>(
        key: String
    ) throws -> Value
        where Value: RawRepresentable
    {
        try queue.sync {
            let rawValue: Value.RawValue = try _get(
                key: key
            )
            
            guard
                let value: Value = .init(rawValue: rawValue)
            else {
                throw UserDefaultsServiceError.failedToGet
            }
            
            return value
        }
    }

    /// Sets `RawRepresentable` with the key.
    open func setRawRepresentable<Value>(
        key: String,
        value: Value
    )
        where Value: RawRepresentable
    {
        set(
            key: key,
            value: value.rawValue
        )
    }

    /// Deletes `RawRepresentable` associated with the key.
    open func deleteRawRepresentable(
        key: String
    ) {
        delete(
            key: key
        )
    }

    // MARK: Operations - Codable
    /// Returns `Codable` associated with the key.
    open func getCodable<Value>(
        key: String
    ) throws -> Value
        where Value: Decodable
    {
        try queue.sync {
            let data: Data = try _get(
                key: key
            )
            
            let value: Value
            do {
                value = try _jsonDecoder.decode(from: data)
            } catch {
                throw UserDefaultsServiceError.failedToGet
            }
            
            return value
        }
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
            data = try _jsonEncoder.encode(value)
        } catch {
            throw UserDefaultsServiceError.failedToSet
        }

        set(
            key: key,
            value: data
        )
    }

    /// Deletes `Codable` associated with the key.
    open func deleteCodable(
        key: String
    ) {
        delete(
            key: key
        )
    }
}
