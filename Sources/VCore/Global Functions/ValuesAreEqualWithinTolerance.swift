//
//  ValuesAreEqualWithinTolerance.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.01.25.
//

import Foundation

// MARK: - Values Are Equal Within Tolerance
/// Returns `Bool` indicating if values are equal within a given tolerance.
///
///     areEqual(3.14, 3.1415, tolerance: pow(10, -2)) // true
///
public func areEqual<T>(
    _ lhs: T,
    _ rhs: T,
    tolerance: T
) -> Bool
    where T: SignedNumeric & Comparable
{
    abs(lhs - rhs) <= tolerance
}
