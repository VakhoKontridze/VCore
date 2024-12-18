//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import SwiftUI

// MARK: - Clamped
@available(*, deprecated, message: "Will be removed in `8.0`")
@propertyWrapper
public struct Clamped<Value>: DynamicProperty, Sendable
    where Value: Sendable
{
    @State private var storage: Value

    public var wrappedValue: Value {
        get { storage }
        nonmutating set { storage = transformation(newValue) }
    }
    
    public var projectedValue: Binding<Value> {
        .init(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    
    private let transformation: @Sendable (Value) -> Value
    
    fileprivate init(
        wrappedValue: Value,
        transformation: @escaping @Sendable (Value) -> Value
    ) {
        self._storage = State(wrappedValue: wrappedValue)
        self.transformation = transformation
    }

    public init(
        wrappedValue: Value,
        _ range: ClosedRange<Value>,
        step: Value? = nil
    )
        where Value: BinaryInteger
    {
        self.init(
            wrappedValue: wrappedValue,
            transformation: { $0.clamped(to: range, step: step) }
        )
    }

    public init(
        wrappedValue: Value,
        _ range: ClosedRange<Value>,
        step: Value? = nil
    )
        where Value: FloatingPoint
    {
        self.init(
            wrappedValue: wrappedValue,
            transformation: { $0.clamped(to: range, step: step) }
        )
    }
}

// MARK: - Old Value Cache
@available(*, deprecated, message: "Will be removed in `8.0`")
@propertyWrapper
public struct OldValueCache<Value>: DynamicProperty, Sendable
    where Value: Sendable
{
    @State private var storage: Value
    @State private var storageOld: Value?
    
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
    
    public var wrappedValueOld: Value? {
        get { storageOld }
        nonmutating set { storageOld = newValue }
    }
    
    public init(wrappedValue: Value) {
        self._storage = State(wrappedValue: wrappedValue)
        self._storageOld = State(wrappedValue: nil)
    }
}

// MARK: - Localization Manager
extension LocalizationManager {
    @available(*, deprecated, message: "Use `static` property instead")
    public var locales: [Locale] {
        Self.locales
    }
}
