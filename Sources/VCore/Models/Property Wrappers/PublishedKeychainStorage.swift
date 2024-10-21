//
//  PublishedKeychainStorage.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.10.24.
//

import SwiftUI
import Combine

// MARK: - Published Keychain Storage
/// Property wrapper type that reflects a value from key chain and invalidates a view on a change in value in that Keychain.
///
///     final class SomeClass: ObservableObject {
///         @PublishedKeychainStorage("AccessToken") var accessToken: String?
///     }
///     
@propertyWrapper
public struct PublishedKeychainStorage<Value>: DynamicProperty, Sendable
    where Value: Sendable & Codable
{
    // MARK: Properties
    private let keychainService: KeychainService
    private let key: String
    private let defaultValue: Value

    @available(*, unavailable, message: "'@PublishedKeychainStorage' is only available on properties of classes")
    public var wrappedValue: Value {
        get { fatalError() }
        nonmutating set { fatalError() }
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

    // MARK: Observable Object Support
    public static subscript<T>(
        _enclosingInstance instance: T,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<T, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<T, Self>
    ) -> Value {
        get {
            let keychainService: KeychainService = instance[keyPath: storageKeyPath].keychainService
            let key: String = instance[keyPath: storageKeyPath].key
            let defaultValue: Value = instance[keyPath: storageKeyPath].defaultValue
            
            return Self.get(keychainService, key, defaultValue)
        }
        set {
            let keychainService: KeychainService = instance[keyPath: storageKeyPath].keychainService
            let key: String = instance[keyPath: storageKeyPath].key
            
            Self.set(keychainService, key, newValue)
            
            if
                let instance = instance as? any ObservableObject,
                let observableObjectPublisher = (instance.objectWillChange as any Publisher) as? ObservableObjectPublisher
            {
                observableObjectPublisher.send()
            }
        }
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
