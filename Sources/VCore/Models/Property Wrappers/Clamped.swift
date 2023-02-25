//
//  Clamped.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.02.23.
//

import Foundation

// MARK: - Clamped
/// A property wrapper type that clamps a value to range.
///
///     @Clamped(1...10) var a: Double = 0 // 1.0
///     @Clamped(1...10) var b: Double = 5 // 5.0
///     @Clamped(1...10) var c: Double = 11 // 10.0
///
///     @Clamped(1...10, step: 3) var a: Double = 0 // 1.0
///     @Clamped(1...10, step: 3) var b: Double = 5 // 4.0
///     @Clamped(1...10, step: 3) var c: Double = 11 // 10.0
///
@propertyWrapper public struct Clamped<Value> {
    // MARK: Properties
    private var fieldValue: Value
    
    /// The underlying value referenced by the state variable.
    public var wrappedValue: Value {
        get { fieldValue }
        set { fieldValue = transformation(newValue) }
    }
    
    private let transformation: (Value) -> Value
     
    // MARK: Initializers
    fileprivate init(
        wrappedValue: Value,
        transformation: @escaping (Value) -> Value
    ) {
        self.fieldValue = transformation(wrappedValue)
        self.transformation = transformation
    }
}

// MARK: Initializers - Binary Integer
extension Clamped where Value: BinaryInteger {
    /// Initializes `Clamped` with range.
    public init(
        wrappedValue: Value,
        _ range: ClosedRange<Value>,
        step: Value? = nil
    ) {
        self.init(
            wrappedValue: wrappedValue,
            transformation: { $0.clamped(to: range, step: step) }
        )
    }
}

// MARK: Initializers - Floating Point
extension Clamped where Value: FloatingPoint {
    /// Initializes `Clamped` with range.
    public init(
        wrappedValue: Value,
        _ range: ClosedRange<Value>,
        step: Value? = nil
    ) {
        self.init(
            wrappedValue: wrappedValue,
            transformation: { $0.clamped(to: range, step: step) }
        )
    }
}
