//
//  OldValueCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.03.23.
//

import SwiftUI

// MARK: - Old Value Cache
/// Property wrapper type that caches and stores old value.
///
///     @OldValueCache private var value: Int = 0
///
///     var body: some View {
///         Button("Increment", action: {
///             print(value, _value.wrappedValueOld) // 0, nil
///             value += 1
///             print(value, _value.wrappedValueOld) // 1, 0
///         })
///     }
///
@propertyWrapper
public struct OldValueCache<Value>: DynamicProperty, Sendable
    where Value: Sendable
{
    // MARK: Properties - Store
    @State private var storage: Value
    @State private var storageOld: Value?
    
    // MARK: Properties - Current
    public var wrappedValue: Value {
        get {
            storage
        }
        nonmutating set {
            storageOld = storage
            storage = newValue
        }
    }

    public var projectedValue: Binding<Value> {
        .init(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    
    // MARK: Properties - Old
    /// Old value.
    public var wrappedValueOld: Value? {
        get { storageOld }
        nonmutating set { storageOld = newValue }
    }
    
    // MARK: Initializers
    /// Initializes `OldValueCache`.
    public init(wrappedValue: Value) {
        self._storage = State(wrappedValue: wrappedValue)
        self._storageOld = State(wrappedValue: nil)
    }
}
