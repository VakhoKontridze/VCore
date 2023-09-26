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
///         static let someCustom: Self = { ... }()
///     }
///
///     @KeychainStorage("AccessToken", configuration: .someCustom) var accessToken: String?
///
/// Or, a reference to an instance of `KeychainService` can be used.
///
///     extension KeychainService {
///         static let someCustom: KeychainService = { ... }()
///     }
///
///     @KeychainStorage("AccessToken", keychainService: .someCustom) var accessToken: String?
///
@propertyWrapper public struct KeychainStorage<Value>: DynamicProperty { // TODO: Add `Observable`-based counterpart when support is added
    // MARK: Properties
    private let keychainService: KeychainService
    
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
        keychainService: KeychainService,
        initialValue: Value,
        valueSetter: @escaping (Value) -> Void
    ) {
        self.keychainService = keychainService
        self.storage = ObservableContainerOO(value: initialValue)
        self.valueSetter = valueSetter
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

// MARK: Initializers - Codable
extension KeychainStorage where Value: Codable {
    /// Initializes `KeychainStorage` from `Codable`.
    public init(
        wrappedValue defaultValue: Value,
        _ key: String,
        keychainService: KeychainService = .default
    ) {
        self.init(
            keychainService: keychainService,
            initialValue: Self.getValue(key: key, defaultValue: defaultValue, in: keychainService),
            valueSetter: { Self.setValue($0, key: key, in: keychainService) }
        )
    }
    
    /// Initializes `KeychainStorage` from `Codable`.
    public init(
        wrappedValue defaultValue: Value,
        _ key: String,
        configuration: KeychainServiceConfiguration
    ) {
        self.init(
            wrappedValue: defaultValue,
            key,
            keychainService: KeychainService(configuration: configuration)
        )
    }
}

extension KeychainStorage where Value: Codable, Value: ExpressibleByNilLiteral {
    /// Initializes `KeychainStorage` from `Optional` `Codable`.
    public init(
        _ key: String,
        keychainService: KeychainService = .default
    ) {
        self.init(
            wrappedValue: nil,
            key,
            keychainService: keychainService
        )
    }
    
    /// Initializes `KeychainStorage` from `Optional` `Codable`.
    public init(
        _ key: String,
        configuration: KeychainServiceConfiguration
    ) {
        self.init(
            wrappedValue: nil,
            key,
            configuration: configuration
        )
    }
}

extension KeychainStorage {
    fileprivate static func getValue<T>(
        key: String,
        defaultValue: T,
        in keychainService: KeychainService
    ) -> T
        where T: Codable
    {
        guard let data: Data = keychainService[key] else { return defaultValue }
        
        do {
            let value: T = try JSONDecoder().decode(T.self, from: data)
            return value
            
        } catch let error {
            VCoreLogError(error)
            return defaultValue
        }
    }
    
    fileprivate static func setValue<T>(
        _ value: T,
        key: String,
        in keychainService: KeychainService
    )
        where T: Encodable
    {
        do {
            keychainService[key] = try JSONEncoder().encode(value)
            
        } catch let error {
            VCoreLogError(error)
        }
    }
}
