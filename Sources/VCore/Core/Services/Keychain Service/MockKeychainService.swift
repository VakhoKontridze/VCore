//
//  MockKeychainService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28/5/26.
//

#if DEBUG

public import Foundation

/// Object that performs get, set, and delete Keychain operations.
nonisolated open class MockKeychainService: KeychainService, @unchecked Sendable {
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
        label: "com.vakhtang-kontridze.vcore.mock-keychain-service",
        attributes: .concurrent
    )
    
    // MARK: Initializers
    /// Initializes `MockKeychainService`.
    public init() {}
    
    // MARK: Operations
    /// Returns `Data` associated with the key.
    open func getData(
        key: String
    ) throws -> Data {
        try queue.sync {
            guard
                let valueAny: Any = storage[key]
            else {
                throw KeychainServiceError.failedToGet
            }

            guard
                let data: Data = valueAny as? Data
            else {
                throw CastingError(from: "\(type(of: valueAny))", to: "Data")
            }

            return data
        }
    }
    
    /// Sets `Data` with the key.
    open func setData(
        key: String,
        value: Data
    ) throws {
        queue.sync(flags: .barrier) {
            storage[key] = value
        }
    }
    
    /// Deletes `Data` associated with the key.
    open func deleteData(
        key: String
    ) throws {
        _ = queue.sync(flags: .barrier) {
            storage.removeValue(forKey: key)
        }
    }
    
    // MARK: Operations
    /// Returns `Codable` associated with the key.
    open func getCodable<Value>(
        key: String
    ) throws -> Value
        where Value: Decodable
    {
        try queue.sync {
            let data: Data = try getData(key: key)

            let value: Value
            do {
                value = try _jsonDecoder.decode(from: data)

            } catch {
                throw KeychainServiceError.failedToGet
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
        try queue.sync(flags: .barrier) {
            let data: Data
            do {
                data = try _jsonEncoder.encode(value)
                
            } catch {
                throw KeychainServiceError.failedToSet
            }

            try setData(
                key: key,
                value: data
            )
        }
    }
    
    /// Deletes `Codable` associated with the key.
    open func deleteCodable(
        key: String
    ) throws {
        try deleteData(
            key: key
        )
    }
    
    // MARK: Subscript
    open subscript(
        key: String
    ) -> Data? {
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

#endif
