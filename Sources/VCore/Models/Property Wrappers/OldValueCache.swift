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
public struct OldValueCache<Value>: DynamicProperty {
    // MARK: Properties - Store
    private let storage: State<Value>
    private let storageOld: State<Value?>
    
    // MARK: Properties - Current
    public var wrappedValue: Value {
        get {
            storage.wrappedValue
        }
        nonmutating set {
            storageOld.wrappedValue = storage.wrappedValue
            storage.wrappedValue = newValue
        }
    }

    public var projectedValue: Binding<Value> {
        storage.projectedValue
    }
    
    // MARK: Properties - Old
    /// Old value.
    public var wrappedValueOld: Value? {
        get { storageOld.wrappedValue }
        nonmutating set { storageOld.wrappedValue = newValue }
    }
    
    // MARK: Initializers
    /// Initializes `OldValueCache`.
    public init(wrappedValue: Value) {
        self.storage = State(wrappedValue: wrappedValue)
        self.storageOld = State(wrappedValue: nil)
    }
}
