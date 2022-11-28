//
//  KeychainServiceConfiguration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11.11.22.
//

import Foundation

// MARK: - Keychain Service Configuration
/// Configuration for `KeychainService`.
public struct KeychainServiceConfiguration {
    // MARK: Properties
    /// Get query.
    public var getQuery: GetQuery
    
    /// Set query.
    public var setQuery: SetQuery
    
    /// Delete query.
    public var deleteQuery: DeleteQuery
    
    // MARK: Initializers
    /// Initializes `KeychainServiceConfiguration`.
    public init(
        getQuery: GetQuery,
        setQuery: SetQuery,
        deleteQuery: DeleteQuery
    ) {
        self.getQuery = getQuery
        self.setQuery = setQuery
        self.deleteQuery = deleteQuery
    }
    
    /// Default instance of `KeychainServiceConfiguration`, that calls `default` instances of properties.
    public static var `default`: Self {
        .init(
            getQuery: .default,
            setQuery: .default,
            deleteQuery: .default
        )
    }
    
    // MARK: Get Query
    /// Get query.
    ///
    /// Declared query shouldn't contain `kSecAttrAccount`, since it is passed in `build(key:)` method.
    public struct GetQuery {
        // MARK: Properties
        /// Query.
        public let query: [String: Any]
        
        // MARK: Initializers
        /// Initializes `GetQuery` with query.
        public init(query: [String: Any]) {
            self.query = query
        }
        
        /// Default instance of `GetQuery`, that uses `defaultQuery`.
        public static var `default`: Self { .init(query: Self.defaultQuery) }
        
        /// Default query.
        public static var defaultQuery: [String: Any] {
            [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrSynchronizable as String: kCFBooleanTrue as Any,
                kSecReturnData as String: kCFBooleanTrue as Any,
                kSecMatchLimit as String: kSecMatchLimitOne
            ]
        }
        
        // MARK: Building
        /// Builds query with key.
        public func build(key: String) -> [String: Any] {
            var query = query
            query[kSecAttrAccount as String] = key
            return query
        }
    }
    
    // MARK: Set Query
    /// Set query.
    ///
    /// Declared query shouldn't contain `kSecAttrAccount` and `kSecValueData`, since they are passed in `build(key:data:)` method.
    public struct SetQuery {
        // MARK: Properties
        /// Query.
        public let query: [String: Any]
        
        // MARK: Initializers
        /// Initializes `SetQuery` with query.
        public init(query: [String: Any]) {
            self.query = query
        }
        
        /// Default instance of `SetQuery`, that uses `defaultQuery`.
        public static var `default`: Self { .init(query: Self.defaultQuery) }
        
        /// Default query.
        public static var defaultQuery: [String: Any] {
            [
                kSecClass as String: kSecClassGenericPassword as String,
                kSecAttrSynchronizable as String: kCFBooleanTrue as Any
            ]
        }
        
        // MARK: Building
        /// Builds query with key and data.
        public func build(key: String, data: Data) -> [String: Any] {
            var query = query
            query[kSecAttrAccount as String] = key
            query[kSecValueData as String] = data
            return query
        }
    }
    
    // MARK: Delete Query
    /// Delete query.
    ///
    /// Declared query shouldn't contain `kSecAttrAccount`, since it is passed in `build(key:)` method.
    public struct DeleteQuery {
        // MARK: Properties
        /// Query.
        public let query: [String: Any]
        
        // MARK: Initializers
        /// Initializes `DeleteQuery` with query.
        public init(query: [String: Any]) {
            self.query = query
        }
        
        /// Default instance of `DeleteQuery`, that uses `defaultQuery`.
        public static var `default`: Self { .init(query: Self.defaultQuery) }
        
        /// Default query.
        public static var defaultQuery: [String: Any] {
            [
                kSecClass as String: kSecClassGenericPassword as String,
                kSecAttrSynchronizable as String: kCFBooleanTrue as Any
            ]
        }
        
        // MARK: Building
        /// Builds query with key.
        public func build(key: String) -> [String: Any] {
            var query = query
            query[kSecAttrAccount as String] = key
            return query
        }
    }
}
