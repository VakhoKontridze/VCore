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
    public func getData(
        key: String
    ) throws -> Data {
        throw KeychainServiceError.mockFailedToGet
    }
    
    public func setData(
        key: String,
        value: Data
    ) throws {}
    
    public func deleteData(
        key: String
    ) throws {}
    
    // MARK: Operations
    public func getCodable<Value>(
        key: String
    ) throws -> Value
        where Value: Decodable
    {
        throw KeychainServiceError.mockFailedToGet
    }
    
    public func setCodable<Value>(
        key: String,
        value: Value
    ) throws
        where Value: Encodable
    {}
    
    public func deleteCodable(
        key: String
    ) throws {}
    
    // MARK: Subscript
    public subscript(
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
