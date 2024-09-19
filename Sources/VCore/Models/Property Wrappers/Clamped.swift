//
//  Clamped.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.02.23.
//

import SwiftUI

// MARK: - Clamped
/// Property wrapper type that clamps a value to range.
///
///     @Clamped(1...10) private var a: Double = 0 // 1.0
///     @Clamped(1...10) private var b: Double = 5 // 5.0
///     @Clamped(1...10) private var c: Double = 11 // 10.0
///
///     @Clamped(1...10, step: 3) private var a: Double = 0 // 1.0
///     @Clamped(1...10, step: 3) private var b: Double = 5 // 4.0
///     @Clamped(1...10, step: 3) private var c: Double = 11 // 10.0
///
@propertyWrapper 
public struct Clamped<Value>: DynamicProperty, Sendable
    where Value: Sendable
{
    // MARK: Properties
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
    
    // MARK: Initializers
    fileprivate init(
        wrappedValue: Value,
        transformation: @escaping @Sendable (Value) -> Value
    ) {
        self._storage = State(wrappedValue: wrappedValue)
        self.transformation = transformation
    }

    /// Initializes `Clamped` with range.
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

    /// Initializes `Clamped` with range.
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
