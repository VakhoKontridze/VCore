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
    // MARK: Initializers
    /// Initializes `MockKeychainService`.
    public init() {}
    
    // MARK: Operations
    /// Returns `Data` associated with the key.
    open func getData(
        key: String
    ) throws -> Data {
        throw KeychainServiceError.mockFailedToGet
    }
    
    /// Sets `Data` with the key.
    open func setData(
        key: String,
        value: Data
    ) throws {}
    
    /// Deletes `Data` associated with the key.
    open func deleteData(
        key: String
    ) throws {}
    
    // MARK: Operations
    /// Returns `Codable` associated with the key.
    open func getCodable<Value>(
        key: String
    ) throws -> Value
        where Value: Decodable
    {
        throw KeychainServiceError.mockFailedToGet
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
    ) throws {}
    
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
