//
//  Comparable+ClampedToClosedRange.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22/10/26.
//

import Foundation

nonisolated extension Comparable {
    /// Clamps value to range.
    ///
    /// `BinaryInteger` and `FloatingPoint` have their own overloads, which also accept a step.
    ///
    ///     let value1: String = "a".clamped(to: "b"..."d") // "b"
    ///     let value2: String = "c".clamped(to: "b"..."d") // "c"
    ///     let value3: String = "e".clamped(to: "b"..."d") // "d"
    ///
    public func clamped(
        to range: ClosedRange<Self>
    ) -> Self {
        if self > range.upperBound {
            range.upperBound
        } else if self < range.lowerBound {
            range.lowerBound
        } else {
            self
        }
    }

    /// Clamps value to range.
    ///
    ///     var value1: String = "a"; value1.clamp(to: "b"..."d") // "b"
    ///     var value2: String = "c"; value2.clamp(to: "b"..."d") // "c"
    ///     var value3: String = "e"; value3.clamp(to: "b"..."d") // "d"
    ///
    public mutating func clamp(
        to range: ClosedRange<Self>
    ) {
        self = clamped(to: range)
    }

    /// Returns value clamped between `min` and `max` values.
    ///
    ///     let value1: String = "a".clamped(min: "b", max: "d") // "b"
    ///     let value2: String = "c".clamped(min: "b", max: "d") // "c"
    ///     let value3: String = "e".clamped(min: "b", max: "d") // "d"
    ///
    public func clamped(
        min: Self,
        max: Self
    ) -> Self {
        clamped(to: min...max)
    }

    /// Clamps value between `min` and `max` values.
    ///
    ///     var value1: String = "a"; value1.clamp(min: "b", max: "d") // "b"
    ///     var value2: String = "c"; value2.clamp(min: "b", max: "d") // "c"
    ///     var value3: String = "e"; value3.clamp(min: "b", max: "d") // "d"
    ///
    public mutating func clamp(
        min: Self,
        max: Self
    ) {
        self = clamped(min: min, max: max)
    }
}
