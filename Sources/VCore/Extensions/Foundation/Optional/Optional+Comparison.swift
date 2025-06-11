//
//  Optional+Comparison.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.02.23.
//

import Foundation

// MARK: - Optional + Comparison
extension Optional {
    /// Returns a `Bool` indicating whether current value is less than that of the second argument with given the `OptionalComparisonNilOrder`.
    ///
    ///     let a: String? = "Lorem ipsum"
    ///     let b: String?
    ///
    ///     a.isOptionalLess(
    ///         than: b,
    ///         order: .nilIsLess
    ///     ) { $0.compare($1, options: .caseInsensitive) == .orderedAscending } // false
    ///
    public func isOptionalLess(
        than other: Self,
        order: OptionalComparisonNilOrder,
        comparison: (Wrapped, Wrapped) -> Bool
    ) -> Bool {
        switch (self, other, order) {
        case (nil, nil, _): false
        case (nil, _?, .nilIsLess): true
        case (nil, _?, .nilIsGreater): false
        case (_?, nil, .nilIsLess): false
        case (_?, nil, .nilIsGreater): true
        case (let lhs?, let rhs?, _): comparison(lhs, rhs)
        }
    }
}

extension Optional where Wrapped: Comparable {
    /// Returns a `Bool` indicating whether current value is less than that of the second argument with given the `OptionalComparisonNilOrder`.
    ///
    ///     let a: Int? = 10
    ///     let b: Int?
    ///
    ///     a.isOptionalLess(than: b, order: .nilIsLess) // false
    ///
    public func isOptionalLess(
        than other: Self,
        order: OptionalComparisonNilOrder
    ) -> Bool {
        switch (self, other, order) {
        case (nil, nil, _): false
        case (nil, _?, .nilIsLess): true
        case (nil, _?, .nilIsGreater): false
        case (_?, nil, .nilIsLess): false
        case (_?, nil, .nilIsGreater): true
        case (let lhs?, let rhs?, _): lhs < rhs
        }
    }
    
    /// Returns a `Bool` indicating whether current value is greater than that of the second argument with given the `OptionalComparisonNilOrder`.
    ///
    ///     let a: Int? = 10
    ///     let b: Int?
    ///
    ///     a.isOptionalGreater(than: b, order: .nilIsLess) // true
    ///
    public func isOptionalGreater(
        than other: Self,
        order: OptionalComparisonNilOrder
    ) -> Bool {
        other.isOptionalLess(than: self, order: order)
    }
    
    /// Returns a `Bool` indicating whether current value is less than or equal to the second value, given the `OptionalComparisonNilOrder`.
    ///
    ///
    ///     let a: Int? = 10
    ///     let b: Int?
    ///
    ///     a.isOptionalLessThanOrEqual(than: b, order: .nilIsLess) // false
    ///
    public func isOptionalLessThanOrEqual(
        to other: Self,
        order: OptionalComparisonNilOrder
    ) -> Bool {
        !(other.isOptionalLess(than: self, order: order))
    }
    
    /// Returns a `Bool` indicating whether current value is greater than or equal to the second value, given the `OptionalComparisonNilOrder`.
    ///
    ///     let a: Int? = 10
    ///     let b: Int?
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
public enum OptionalComparisonNilOrder: Int, Sendable, CaseIterable {
    /// Indicates that `nil` is less than wrapped value.
    case nilIsLess
    
    /// Indicates that `nil` is greater than wrapped value.
    case nilIsGreater
}
