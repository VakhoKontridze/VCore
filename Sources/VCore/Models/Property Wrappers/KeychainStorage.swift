//
//  KeychainStorage.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.07.22.
//

import SwiftUI
import Combine

// MARK: - Keychain Storage
/// Property wrapper type that reflects a value from key chain and invalidates a view on a change in value in that Keychain.
///
///     @KeychainStorage("AccessToken") var accessToken: String?
///
@propertyWrapper
public struct KeychainStorage<Value>: DynamicProperty, Sendable
    where Value: Sendable & Codable
{
    // MARK: Properties
    private let keychainService: KeychainService
    private let key: String
    private let defaultValue: Value
    
    @State private var storage: Value

    public var wrappedValue: Value {
        get {
            storage
        }
        nonmutating set {
            storage = newValue
            Self.set(keychainService, key, newValue)
        }
    }
    
    public var projectedValue: Binding<Value> {
        .init(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    
    // MARK: Initializers
    /// Initializes `KeychainStorage` with value.
    public init(
        wrappedValue defaultValue: Value,
        _ key: String,
        keychainService: KeychainService = .default
    ) {
        self.keychainService = keychainService
        self.key = key
        self.defaultValue = defaultValue
        
        let initialValue: Value = Self.get(keychainService, key, defaultValue)
        self._storage = State(wrappedValue: initialValue)
    }

    /// Initializes `KeychainStorage` with `Optional` value.
    public init(
        _ key: String,
        keychainService: KeychainService = .default
    )
        where Value: ExpressibleByNilLiteral
    {
        self.init(
            wrappedValue: nil,
            key,
            keychainService: keychainService
        )
    }
    
    // MARK: Get & Set
    private static func get(
        _ keychainService: KeychainService,
        _ key: String,
        _ defaultValue: Value
    ) -> Value {
        if let value: Value = try? keychainService.getCodable(key: key) {
            return value
            
        } else {
            return defaultValue
        }
    }
    
    private static func set(
        _ keychainService: KeychainService,
        _ key: String,
        _ newValue: Value
    ) {
        try? keychainService.setCodable(key: key, value: newValue)
    }
}
