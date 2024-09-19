//
//  KeyPathEqualityAndCompraison.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 18.06.22.
//

import Foundation

// MARK: - Is Equal by KeyPath
/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given `KeyPath`s.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b)
///
public func isEqual<T, each Property: Equatable>(
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

// MARK: - Is Less than by KeyPath
/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b)
///
public func isLess<T, each Property: Comparable>(
    _ lhs: T,
    than rhs: T,
    by keyPaths: repeat KeyPath<T, each Property>
) -> Bool {
    for keyPath in repeat each keyPaths {
        if lhs[keyPath: keyPath] != rhs[keyPath: keyPath] {
            return lhs[keyPath: keyPath] < rhs[keyPath: keyPath]
        }
    }
    
    return false
}

// MARK: - Is Less than or Equal to by KeyPath
/// Returns a `Bool` value indicating whether the value of the first argument is less than or equal to that of the second argument with given `KeyPath`s.
///
///     isLessThanOrEqual(objectA, to: objectB, by: \.a, \.b)
///
public func isLessThanOrEqual<T, each Property: Comparable>(
    _ lhs: T,
    to rhs: T,
    by keyPaths: repeat KeyPath<T, each Property>
) -> Bool {
    !isLess(rhs, than: lhs, by: repeat each keyPaths)
}

// MARK: - Is Greater than by KeyPath
/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given `KeyPath`s.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b)
///
public func isGreater<T, each Property: Comparable>(
    _ lhs: T,
    than rhs: T,
    by keyPaths: repeat KeyPath<T, each Property>
) -> Bool {
    isLess(rhs, than: lhs, by: repeat each keyPaths)
}

// MARK: - Is Greater than or Equal to by KeyPath
/// Returns a `Bool` value indicating whether the value of the first argument is greater than or equal to that of the second argument with given `KeyPath`s.
///
///     isGreaterThanOrEqual(objectA, to: objectB, by: \.a, \.b)
///
public func isGreaterThanOrEqual<T, each Property: Comparable>(
    _ lhs: T,
    to rhs: T,
    by keyPaths: repeat KeyPath<T, each Property>
) -> Bool {
    !isLess(lhs, than: rhs, by: repeat each keyPaths)
}
