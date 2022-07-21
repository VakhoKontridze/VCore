//
//  KeychainStorage.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.07.22.
//

import Foundation
import SwiftUI
import Combine

// MARK: - Keychain Storage
/// A property wrapper type that reflects a value from key chain and invalidates a view on a change in value in that key chain.
///
/// Unlike `SwiftUI`'s `AppStorage`, a `class` containing `KeychainStorage` must conform to `ObservableObject`.
@propertyWrapper public struct KeychainStorage<Value>: DynamicProperty {
    // MARK: Properties
    @ObservedObject private var storage: ObservableStorage<Value>
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
    
    // MARK: Get and Set
    private static func getValue<T>(
        key: String,
        defaultValue: T
    ) -> T
        where T: Codable
    {
        if
            let data: Data = KeychainService.get(key: key),
            let value: T = decode(data)
        {
            KeychainService.set(key: key, data: nil) // Removes data is type is changed
            return value

        } else {
            KeychainService.set(key: key, data: encode(defaultValue))
            return defaultValue
        }
    }

    private static func setValue<T>(
        _ value: T,
        key: String
    )
        where T: Encodable
    {
        KeychainService.set(key: key, data: encode(value))
    }

    private static func encode<T>(
        _ value: T
    ) -> Data?
        where T: Encodable
    {
        try? JSONEncoder().encode(value)
    }

    private static func decode<T>(
        _ data: Data
    ) -> T?
        where T: Decodable
    {
        try? JSONDecoder().decode(T.self, from: data)
    }
}

// MARK: Initializers - Codable
extension KeychainStorage where Value: Codable {
    /// Initializes `KeychainStorage` from `Codable`.
    public init(
        wrappedValue defaultValue: Value,
        _ key: String
    ) {
        self.init(
            initialValue: Self.getValue(key: key, defaultValue: defaultValue),
            valueSetter: { Self.setValue($0, key: key) }
        )
    }
}

extension KeychainStorage where Value: Codable, Value: ExpressibleByNilLiteral {
    /// Initializes `KeychainStorage` from `nil` `Codable` literal.
    public init(
        _ key: String
    ) {
        self.init(
            wrappedValue: nil,
            key
        )
    }
}

// MARK: Initializers - Raw Representable
//extension KeychainStorage where Value: RawRepresentable, Value.RawValue: Codable {
//    /// Initializes `KeychainStorage` from `RawRepresentable`.
//    public init(
//        wrappedValue defaultValue: Value,
//        _ key: String
//    ) {
//        self.init(
//            initialValue: .init(rawValue: Self.getValue(key: key, defaultValue: defaultValue.rawValue))!,
//            valueSetter: { Self.setValue($0.rawValue, key: key) }
//        )
//    }
//}
//
//extension KeychainStorage where Value: RawRepresentable, Value.RawValue: Codable, Value: ExpressibleByNilLiteral {
//    /// Initializes `KeychainStorage` from `nil` `RawRepresentable` literal.
//    public init(
//        _ key: String
//    ) {
//        self.init(
//            wrappedValue: nil,
//            key
//        )
//    }
//}

// MARK: - Observable Storage
private final class ObservableStorage<Value>: ObservableObject {
    // MARK: Properties
    @Published var value: Value
    
    // MARK: Initializers
    init(value: Value) {
        self.value = value
    }
}
