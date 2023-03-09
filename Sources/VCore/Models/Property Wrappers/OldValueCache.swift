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
///         Button("Test", action: {
///             print(value, _value.wrappedValueOld) // 0, nil
///             value += 1
///             print(value, _value.wrappedValueOld) // 1, 0
///         })
///     }
///
@propertyWrapper public struct OldValueCache<Value>: DynamicProperty {
    // MARK: Properties
    /// Old value.
    @State private(set) public var wrappedValueOld: Value?

    @State private var fieldValue: Value
    public var wrappedValue: Value {
        get {
            fieldValue
        }
        nonmutating set {
            wrappedValueOld = fieldValue
            fieldValue = newValue
        }
    }

    // MARK: Initializers
    /// Initializes `OldValueCache`.
    public init(wrappedValue: Value) {
        self._fieldValue = .init(initialValue: wrappedValue)
    }
}
