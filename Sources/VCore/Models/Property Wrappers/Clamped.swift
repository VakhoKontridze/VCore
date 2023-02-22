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
@propertyWrapper public struct Clamped<Value> where Value: FloatingPoint {
    // MARK: Properties
    private var fieldValue: Value
    
    /// The underlying value referenced by the state variable.
    public var wrappedValue: Value {
        get { fieldValue }
        set { fieldValue = Self.transform(newValue, range: range) }
    }
    
    private let range: ClosedRange<Value>
     
    // MARK: Initializers
    /// Initializes `Clamped` with range.
    public init(
        wrappedValue: Value,
        _ range: ClosedRange<Value>
    ) {
        self.fieldValue = Self.transform(wrappedValue, range: range)
        self.range = range
    }
    
    // MARK: Transform
    private static func transform(
        _ value: Value,
        range: ClosedRange<Value>
    ) -> Value {
        value.clamped(to: range)
    }
}
