//
//  Optional.Comparison.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.02.23.
//

import Foundation

// MARK: - Optional Comparison
extension Optional where Wrapped: Comparable {
    /// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `OptionalComparisonNilOrder`.
    ///
    ///     let a: Int? = 10
    ///     let b: Int? = nil
    ///
    ///     a.isOptionalLess(than: b, order: .nilIsLess) // false
    ///
    public func isOptionalLess(
        than other: Self,
        order: OptionalComparisonNilOrder
    ) -> Bool {
        switch (self, other, order) {
        case (nil, nil, _): return false
        case (nil, _?, .nilIsLess): return true
        case (nil, _?, .nilIsGreater): return false
        case (_?, nil, .nilIsLess): return false
        case (_?, nil, .nilIsGreater): return true
        case (let lhs?, let rhs?, _): return lhs < rhs
        }
    }
    
    /// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given `OptionalComparisonNilOrder`.
    ///
    ///     let a: Int? = 10
    ///     let b: Int? = nil
    ///
    ///     a.isOptionalGreater(than: b, order: .nilIsLess) // true
    ///
    public func isOptionalGreater(
        than other: Self,
        order: OptionalComparisonNilOrder
    ) -> Bool {
        other.isOptionalLess(than: self, order: order)
    }
    
    /// Returns a `Bool` value indicating whether the value of the first argument is less than or equal to that of the second argument with given `OptionalComparisonNilOrder`.
    ///
    ///
    ///     let a: Int? = 10
    ///     let b: Int? = nil
    ///
    ///     a.isOptionalLessThanOrEqual(than: b, order: .nilIsLess) // false
    ///
    public func isOptionalLessThanOrEqual(
        to other: Self,
        order: OptionalComparisonNilOrder
    ) -> Bool {
        !(other.isOptionalLess(than: self, order: order))
    }
    
    /// Returns a `Bool` value indicating whether the value of the first argument is greater than or equal to that of the second argument with given `OptionalComparisonNilOrder`.
    ///
    ///     let a: Int? = 10
    ///     let b: Int? = nil
    ///
    ///     a.isOptionalLessThanOrEqual(than: b, order: .nilIsLess) // true
    ///
    public func isOptionalGreaterThanOrEqual(
        to other: Self,
        order: OptionalComparisonNilOrder
    ) -> Bool {
        !(isOptionalLess(than: other, order: order))
    }
}

// MARK: - Optional Comparison Nil Order
/// Constants that indicate sort order within optionals.
public enum OptionalComparisonNilOrder {
    /// Indicates that `nil` is less than wrapped value.
    case nilIsLess
    
    /// Indicates that `nil` is greater than wrapped value.
    case nilIsGreater
}
