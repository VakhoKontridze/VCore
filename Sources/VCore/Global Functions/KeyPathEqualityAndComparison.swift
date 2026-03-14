//
//  KeyPathEqualityAndComparison.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 18.06.22.
//

import Foundation

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given `KeyPath`s.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b)
///
public nonisolated func isEqual<T, each Property: Equatable>(
    _ lhs: T,
    to rhs: T,
    by keyPaths: repeat KeyPath<T, each Property>
) -> Bool {
    for keyPath in repeat each keyPaths {
        guard lhs[keyPath: keyPath] == rhs[keyPath: keyPath] else {
            return false
        }
    }
    
    return true
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b)
///
public nonisolated func isLess<T, each Property: Comparable>(
    _ lhs: T,
    than rhs: T,
    by keyPaths: repeat KeyPath<T, each Property>
) -> Bool {
    for keyPath in repeat each keyPaths {
        let lhs = lhs[keyPath: keyPath]
        let rhs = rhs[keyPath: keyPath]
        
        if lhs != rhs {
            return lhs < rhs
        }
    }
    
    return false
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than or equal to that of the second argument with given `KeyPath`s.
///
///     isLessThanOrEqual(objectA, to: objectB, by: \.a, \.b)
///
public nonisolated func isLessThanOrEqual<T, each Property: Comparable>(
    _ lhs: T,
    to rhs: T,
    by keyPaths: repeat KeyPath<T, each Property>
) -> Bool {
    !isLess(rhs, than: lhs, by: repeat each keyPaths)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given `KeyPath`s.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b)
///
public nonisolated func isGreater<T, each Property: Comparable>(
    _ lhs: T,
    than rhs: T,
    by keyPaths: repeat KeyPath<T, each Property>
) -> Bool {
    isLess(rhs, than: lhs, by: repeat each keyPaths)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than or equal to that of the second argument with given `KeyPath`s.
///
///     isGreaterThanOrEqual(objectA, to: objectB, by: \.a, \.b)
///
public nonisolated func isGreaterThanOrEqual<T, each Property: Comparable>(
    _ lhs: T,
    to rhs: T,
    by keyPaths: repeat KeyPath<T, each Property>
) -> Bool {
    !isLess(lhs, than: rhs, by: repeat each keyPaths)
}
