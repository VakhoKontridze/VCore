//
//  KeychainStorage.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.07.22.
//

import SwiftUI
import Combine

// MARK: - Keychain Storage
/// A property wrapper type that reflects a value from key chain and invalidates a view on a change in value in that key chain.
///
/// Unlike `SwiftUI`'s `AppStorage`, a `class` containing `KeychainStorage` must conform to `ObservableObject`.
///
///     @KeychainStorage("AccessToken") var accessToken: String?
///
/// Alternately, a `KeychainServiceConfiguration` can be passed to customize queries.
///
///     static let configuration: KeychainServiceConfiguration = { ... }()
///     @KeychainStorage("AccessToken", configuration: .default) var accessToken: String?
///
/// Or, a reference to an instance of `KeychainService` can be used.
///
///     static let keychainService: KeychainService = { ... }()
///     @KeychainStorage("AccessToken", keychainService: keychainService) var accessToken: String?
///
@propertyWrapper public struct KeychainStorage<Value>: DynamicProperty {
    // MARK: Properties
    private let keychainService: KeychainService
    
    @ObservedObject private var storage: ObservableContainer<Value>
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
        self.storage = .init(value: initialValue)
        self.valueSetter = valueSetter
    }
    
    // MARK: Observable Support
    public static subscript<T: ObservableObject>(
        _enclosingInstance instance: T,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<T, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<T, Self>
    ) -> Value {
        get {
            instance[keyPath: storageKeyPath].wrappedValue
        }
        set {
            instance[keyPath: storageKeyPath].wrappedValue = newValue
            (instance.objectWillChange as? ObservableObjectPublisher)?.send()
        }
    }
}

// MARK: Initializers - Codable
extension KeychainStorage where Value: Codable {
    /// Initializes `KeychainStorage` from `Codable`.
    public init(
        wrappedValue defaultValue: Value,
        _ key: String,
        keychainService: KeychainService
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
        configuration: KeychainServiceConfiguration = .default
    ) {
        self.init(
            wrappedValue: defaultValue,
            key,
            keychainService: .init(configuration: configuration)
        )
    }
}

extension KeychainStorage where Value: Codable, Value: ExpressibleByNilLiteral {
    /// Initializes `KeychainStorage` from `Optional` `Codable`.
    public init(
        _ key: String,
        keychainService: KeychainService
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
        configuration: KeychainServiceConfiguration = .default
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
        let encodeDefaultValue: () -> Void = {
            (try? JSONEncoder().encode(defaultValue)).map { keychainService[key] = $0 }
        }
        
        guard let data: Data = keychainService[key] else {
            encodeDefaultValue()
            return defaultValue
        }
        
        do {
            let value: T = try JSONDecoder().decode(T.self, from: data)
            return value
            
        } catch let _error {
            let error: KeychainServiceError = .init(.failedToSet)
            VCoreLog(error, _error)
            
            encodeDefaultValue()
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

        } catch let _error {
            let error: KeychainServiceError = .init(.failedToSet)
            VCoreLog(error, _error)
        }
    }
}
