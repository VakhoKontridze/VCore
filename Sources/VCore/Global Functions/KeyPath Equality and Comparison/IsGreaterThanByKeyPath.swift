//
//  IsGreaterThanByKeyPath.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 18.06.22.
//

import Foundation

// MARK: - Is Greater than by KeyPath
/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given `KeyPath`'s.
///
///     isGreater(objectA, than: objectB, by: \.a)
///
public func isGreater<T, P0>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, P0>
) -> Bool
    where
        P0: Comparable
{
    isLess(rhs, than: lhs, by: keyPath0)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given `KeyPath`'s.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b)
///
public func isGreater<T, P0, P1>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, P0>,
    _ keyPath1: KeyPath<T, P1>
) -> Bool
    where
        P0: Comparable,
        P1: Comparable
{
    isLess(rhs, than: lhs, by: keyPath0, keyPath1)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given `KeyPath`'s.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c)
///
public func isGreater<T, P0, P1, P2>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, P0>,
    _ keyPath1: KeyPath<T, P1>,
    _ keyPath2: KeyPath<T, P2>
) -> Bool
    where
        P0: Comparable,
        P1: Comparable,
        P2: Comparable
{
    isLess(rhs, than: lhs, by: keyPath0, keyPath1, keyPath2)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given `KeyPath`'s.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c, \.d)
///
public func isGreater<T, P0, P1, P2, P3>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, P0>,
    _ keyPath1: KeyPath<T, P1>,
    _ keyPath2: KeyPath<T, P2>,
    _ keyPath3: KeyPath<T, P3>
) -> Bool
    where
        P0: Comparable,
        P1: Comparable,
        P2: Comparable,
        P3: Comparable
{
    isLess(rhs, than: lhs, by: keyPath0, keyPath1, keyPath2, keyPath3)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given `KeyPath`'s.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e)
///
public func isGreater<T, P0, P1, P2, P3, P4>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, P0>,
    _ keyPath1: KeyPath<T, P1>,
    _ keyPath2: KeyPath<T, P2>,
    _ keyPath3: KeyPath<T, P3>,
    _ keyPath4: KeyPath<T, P4>
) -> Bool
    where
        P0: Comparable,
        P1: Comparable,
        P2: Comparable,
        P3: Comparable,
        P4: Comparable
{
    isLess(rhs, than: lhs, by: keyPath0, keyPath1, keyPath2, keyPath3, keyPath4)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given `KeyPath`'s.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f)
///
public func isGreater<T, P0, P1, P2, P3, P4, P5>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, P0>,
    _ keyPath1: KeyPath<T, P1>,
    _ keyPath2: KeyPath<T, P2>,
    _ keyPath3: KeyPath<T, P3>,
    _ keyPath4: KeyPath<T, P4>,
    _ keyPath5: KeyPath<T, P5>
) -> Bool
    where
        P0: Comparable,
        P1: Comparable,
        P2: Comparable,
        P3: Comparable,
        P4: Comparable,
        P5: Comparable
{
    isLess(rhs, than: lhs, by: keyPath0, keyPath1, keyPath2, keyPath3, keyPath4, keyPath5)
}
