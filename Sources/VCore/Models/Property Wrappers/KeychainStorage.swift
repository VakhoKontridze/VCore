//
//  KeychainStorage.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.07.22.
//

import SwiftUI
import Combine

// MARK: - Keychain Storage
/// Property wrapper type that reflects a value from key chain and invalidates a view on a change in value in that key chain.
///
///     @KeychainStorage("AccessToken") var accessToken: String?
///
/// Alternately, a `KeychainServiceConfiguration` can be passed to customize queries.
///
///     extension KeychainServiceConfiguration {
///         static let someCustomConfiguration: Self = ...
///     }
///
///     @KeychainStorage("AccessToken", configuration: .someCustomConfiguration) var accessToken: String?
///
/// Or, a reference to an instance of `KeychainService` can be used.
///
///     extension KeychainService {
///         static let someCustomConfiguration: KeychainService = ...
///     }
///
///     @KeychainStorage("AccessToken", keychainService: .someCustomConfiguration) var accessToken: String?
///
@propertyWrapper
public struct KeychainStorage<Value>: DynamicProperty {
    // MARK: Properties
    @ObservedObject private var storage: ObservableContainerOO<Value> // No need for `StateObject`
    private let valueSetter: (Value) -> Void
    
    /// The underlying value referenced by the state variable.
    public var wrappedValue: Value {
        get {
            storage.value
        }
        nonmutating set {
            storage.value = newValue
            valueSetter(newValue)
        }
    }
    
    /// The property for which this instance exposes a publisher.
    public var projectedValue: Binding<Value> {
        .init(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    
    // MARK: Initializers
    fileprivate init(
        initialValue: Value,
        valueSetter: @escaping (Value) -> Void
    ) {
        self.storage = ObservableContainerOO(value: initialValue)
        self.valueSetter = valueSetter
    }

    // MARK: Initializers - Codable
    /// Initializes `KeychainStorage` from `Codable`.
    public init(
        wrappedValue defaultValue: Value,
        _ key: String,
        keychainService: KeychainService = .default
    ) 
        where Value: Codable
    {
        self.init(
            initialValue: (try? keychainService.getCodable(key: key)) ?? defaultValue,
            valueSetter: { try? keychainService.setCodable(key: key, value: $0) }
        )
    }

    /// Initializes `KeychainStorage` from `Optional` `Codable`.
    public init(
        _ key: String,
        keychainService: KeychainService = .default
    )
        where Value: Codable & ExpressibleByNilLiteral
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
            instance[keyPath: storageKeyPath].wrappedValue
        }
        set {
            instance[keyPath: storageKeyPath].wrappedValue = newValue
            
            if
                let instance = instance as? any ObservableObject,
                let observableObjectPublisher = (instance.objectWillChange as any Publisher) as? ObservableObjectPublisher
            {
                observableObjectPublisher.send()
            }
        }
    }
}
