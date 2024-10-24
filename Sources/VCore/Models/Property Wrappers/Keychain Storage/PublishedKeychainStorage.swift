//
//  PublishedKeychainStorage.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.10.24.
//

import SwiftUI
import Combine

// MARK: - Published Keychain Storage
/// Property wrapper type that reflects a value from Keychain and invalidates a view on a change in value in that Keychain.
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
    private let valueSetter: @Sendable (Value) -> Void

    @PublishedPropertyWrapperBox private var storage: PublishedPropertyWrapperStorage<Value>
    
    @available(*, unavailable, message: "'PublishedKeychainStorage' is only available on properties of 'class'es. Use 'KeychainStorage' instead.")
    public var wrappedValue: Value {
        get { fatalError() }
        nonmutating set { fatalError() }
    }
    
    public var projectedValue: PublishedPropertyWrapperPublisher<Value> {
        mutating get { storage.publisher }
        set { storage.publisher = newValue }
    }
    
    // MARK: Initializers
    /// Initializes `PublishedKeychainStorage` with value.
    public init(
        wrappedValue defaultValue: Value,
        _ key: String,
        keychainService: KeychainService = .default
    ) {
        self.valueSetter = { try? keychainService.setCodable(key: key, value: $0) }
        
        let initialValue: Value = (try? keychainService.getCodable(key: key)) ?? defaultValue
        self._storage = PublishedPropertyWrapperBox(wrappedValue: .value(initialValue))
    }

    /// Initializes `PublishedKeychainStorage`.
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
            instance[keyPath: storageKeyPath].storage.value
        }
        set {
            instance[keyPath: storageKeyPath].valueSetter(newValue)
            
            instance[keyPath: storageKeyPath].storage.update(newValue)
            
            if
                let instance = instance as? any ObservableObject,
                let observableObjectPublisher = (instance.objectWillChange as any Publisher) as? ObservableObjectPublisher
            {
                observableObjectPublisher.send()
            }
        }
    }
}
