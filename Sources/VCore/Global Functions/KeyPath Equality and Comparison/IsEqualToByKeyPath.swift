//
//  IsEqualToByKeyPath.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 18.06.22.
//

import Foundation

// MARK: - Is Equal by KeyPath
/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given `KeyPath`'s.
///
///     isEqual(objectA, to: objectB, by: \.a)
///
public func isEqual<T, P0>(
    _ lhs: T,
    to rhs: T,
    by keyPath0: KeyPath<T, P0>
) -> Bool
    where
        P0: Equatable
{
    lhs[keyPath: keyPath0] ==
    rhs[keyPath: keyPath0]
}

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given `KeyPath`'s.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b)
///
public func isEqual<T, P0, P1>(
    _ lhs: T,
    to rhs: T,
    by keyPath0: KeyPath<T, P0>,
    _ keyPath1: KeyPath<T, P1>
) -> Bool
    where
        P0: Equatable,
        P1: Equatable
{
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1]) ==
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1])
}

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given `KeyPath`'s.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b, \.c)
///
public func isEqual<T, P0, P1, P2>(
    _ lhs: T,
    to rhs: T,
    by keyPath0: KeyPath<T, P0>,
    _ keyPath1: KeyPath<T, P1>,
    _ keyPath2: KeyPath<T, P2>
) -> Bool
    where
        P0: Equatable,
        P1: Equatable,
        P2: Equatable
{
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1], lhs[keyPath: keyPath2]) ==
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1], rhs[keyPath: keyPath2])
}

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given `KeyPath`'s.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b, \.c, \.d)
///
public func isEqual<T, P0, P1, P2, P3>(
    _ lhs: T,
    to rhs: T,
    by keyPath0: KeyPath<T, P0>,
    _ keyPath1: KeyPath<T, P1>,
    _ keyPath2: KeyPath<T, P2>,
    _ keyPath3: KeyPath<T, P3>
) -> Bool
    where
        P0: Equatable,
        P1: Equatable,
        P2: Equatable,
        P3: Equatable
{
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1], lhs[keyPath: keyPath2], lhs[keyPath: keyPath3]) ==
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1], rhs[keyPath: keyPath2], rhs[keyPath: keyPath3])
}

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given `KeyPath`'s.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b, \.c, \.d, \.e)
///
public func isEqual<T, P0, P1, P2, P3, P4>(
    _ lhs: T,
    to rhs: T,
    by keyPath0: KeyPath<T, P0>,
    _ keyPath1: KeyPath<T, P1>,
    _ keyPath2: KeyPath<T, P2>,
    _ keyPath3: KeyPath<T, P3>,
    _ keyPath4: KeyPath<T, P4>
) -> Bool
    where
        P0: Equatable,
        P1: Equatable,
        P2: Equatable,
        P3: Equatable,
        P4: Equatable
{
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1], lhs[keyPath: keyPath2], lhs[keyPath: keyPath3], lhs[keyPath: keyPath4]) ==
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1], rhs[keyPath: keyPath2], rhs[keyPath: keyPath3], rhs[keyPath: keyPath4])
}

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given `KeyPath`'s.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f)
///
public func isEqual<T, P0, P1, P2, P3, P4, P5>(
    _ lhs: T,
    to rhs: T,
    by keyPath0: KeyPath<T, P0>,
    _ keyPath1: KeyPath<T, P1>,
    _ keyPath2: KeyPath<T, P2>,
    _ keyPath3: KeyPath<T, P3>,
    _ keyPath4: KeyPath<T, P4>,
    _ keyPath5: KeyPath<T, P5>
) -> Bool
    where
        P0: Equatable,
        P1: Equatable,
        P2: Equatable,
        P3: Equatable,
        P4: Equatable,
        P5: Equatable
{
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1], lhs[keyPath: keyPath2], lhs[keyPath: keyPath3], lhs[keyPath: keyPath4], lhs[keyPath: keyPath5]) ==
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1], rhs[keyPath: keyPath2], rhs[keyPath: keyPath3], rhs[keyPath: keyPath4], rhs[keyPath: keyPath5])
}
