//
//  IsEqualToByKeyPath.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 18.06.22.
//

import Foundation

// MARK: - Is Equal by KeyPath
/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given keypaths.
///
///     isEqual(objectA, to: objectB, by: \.a)
///
public func isEqual<T, P0>(
    _ lhs: T,
    to rhs: T,
    by keypath0: KeyPath<T, P0>
) -> Bool
    where
        P0: Equatable
{
    lhs[keyPath: keypath0] ==
    rhs[keyPath: keypath0]
}

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given keypaths.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b)
///
public func isEqual<T, P0, P1>(
    _ lhs: T,
    to rhs: T,
    by keypath0: KeyPath<T, P0>,
    _ keypath1: KeyPath<T, P1>
) -> Bool
    where
        P0: Equatable,
        P1: Equatable
{
    (lhs[keyPath: keypath0], lhs[keyPath: keypath1]) ==
    (rhs[keyPath: keypath0], rhs[keyPath: keypath1])
}

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given keypaths.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b, \.c)
///
public func isEqual<T, P0, P1, P2>(
    _ lhs: T,
    to rhs: T,
    by keypath0: KeyPath<T, P0>,
    _ keypath1: KeyPath<T, P1>,
    _ keypath2: KeyPath<T, P2>
) -> Bool
    where
        P0: Equatable,
        P1: Equatable,
        P2: Equatable
{
    (lhs[keyPath: keypath0], lhs[keyPath: keypath1], lhs[keyPath: keypath2]) ==
    (rhs[keyPath: keypath0], rhs[keyPath: keypath1], rhs[keyPath: keypath2])
}

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given keypaths.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b, \.c, \.d)
///
public func isEqual<T, P0, P1, P2, P3>(
    _ lhs: T,
    to rhs: T,
    by keypath0: KeyPath<T, P0>,
    _ keypath1: KeyPath<T, P1>,
    _ keypath2: KeyPath<T, P2>,
    _ keypath3: KeyPath<T, P3>
) -> Bool
    where
        P0: Equatable,
        P1: Equatable,
        P2: Equatable,
        P3: Equatable
{
    (lhs[keyPath: keypath0], lhs[keyPath: keypath1], lhs[keyPath: keypath2], lhs[keyPath: keypath3]) ==
    (rhs[keyPath: keypath0], rhs[keyPath: keypath1], rhs[keyPath: keypath2], rhs[keyPath: keypath3])
}

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given keypaths.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b, \.c, \.d, \.e)
///
public func isEqual<T, P0, P1, P2, P3, P4>(
    _ lhs: T,
    to rhs: T,
    by keypath0: KeyPath<T, P0>,
    _ keypath1: KeyPath<T, P1>,
    _ keypath2: KeyPath<T, P2>,
    _ keypath3: KeyPath<T, P3>,
    _ keypath4: KeyPath<T, P4>
) -> Bool
    where
        P0: Equatable,
        P1: Equatable,
        P2: Equatable,
        P3: Equatable,
        P4: Equatable
{
    (lhs[keyPath: keypath0], lhs[keyPath: keypath1], lhs[keyPath: keypath2], lhs[keyPath: keypath3], lhs[keyPath: keypath4]) ==
    (rhs[keyPath: keypath0], rhs[keyPath: keypath1], rhs[keyPath: keypath2], rhs[keyPath: keypath3], rhs[keyPath: keypath4])
}

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given keypaths.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f)
///
public func isEqual<T, P0, P1, P2, P3, P4, P5>(
    _ lhs: T,
    to rhs: T,
    by keypath0: KeyPath<T, P0>,
    _ keypath1: KeyPath<T, P1>,
    _ keypath2: KeyPath<T, P2>,
    _ keypath3: KeyPath<T, P3>,
    _ keypath4: KeyPath<T, P4>,
    _ keypath5: KeyPath<T, P5>
) -> Bool
    where
        P0: Equatable,
        P1: Equatable,
        P2: Equatable,
        P3: Equatable,
        P4: Equatable,
        P5: Equatable
{
    (lhs[keyPath: keypath0], lhs[keyPath: keypath1], lhs[keyPath: keypath2], lhs[keyPath: keypath3], lhs[keyPath: keypath4], lhs[keyPath: keypath5]) ==
    (rhs[keyPath: keypath0], rhs[keyPath: keypath1], rhs[keyPath: keypath2], rhs[keyPath: keypath3], rhs[keyPath: keypath4], rhs[keyPath: keypath5])
}
