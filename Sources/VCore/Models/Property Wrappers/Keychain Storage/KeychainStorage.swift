//
//  KeychainStorage.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.07.22.
//

import SwiftUI
import Combine

// MARK: - Keychain Storage
/// Property wrapper type that reflects a value from Keychain and invalidates a view on a change in value in that Keychain.
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
    
    @State private var storage: Value

    public var wrappedValue: Value {
        get {
            storage
        }
        nonmutating set {
            try? keychainService.setCodable(key: key, value: newValue)
            storage = newValue
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
        
        let initialValue: Value = (try? keychainService.getCodable(key: key)) ?? defaultValue
        self._storage = State(wrappedValue: initialValue)
    }

    /// Initializes `KeychainStorage`.
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
    
    // MARK: Observable Object Support
    public static subscript<EnclosingSelf>(
        _enclosingInstance instance: EnclosingSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Self>
    ) -> Value
        where EnclosingSelf: AnyObject
    {
        get {
            fatalError("'KeychainStorage' is only available on properties of 'struct's. Use 'PublishedKeychainStorage' instead.")
        }
        set {
            fatalError("'KeychainStorage' is only available on properties of 'struct's. Use 'PublishedKeychainStorage' instead.")
        }
    }
}
