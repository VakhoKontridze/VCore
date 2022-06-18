//
//  IsGreaterThanByKeyPath.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 18.06.22.
//

import Foundation

// MARK: - Is Greater than by KeyPath
/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given keypaths.
///
///     isGreater(objectA, than: objectB, by: \.a)
///
public func isGreater<T, P0>(
    _ lhs: T,
    than rhs: T,
    by keypath0: KeyPath<T, P0>
) -> Bool
    where
        P0: Comparable
{
    isLess(rhs, than: lhs, by: keypath0)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given keypaths.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b)
///
public func isGreater<T, P0, P1>(
    _ lhs: T,
    than rhs: T,
    by keypath0: KeyPath<T, P0>,
    _ keypath1: KeyPath<T, P1>
) -> Bool
    where
        P0: Comparable,
        P1: Comparable
{
    isLess(rhs, than: lhs, by: keypath0, keypath1)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given keypaths.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c)
///
public func isGreater<T, P0, P1, P2>(
    _ lhs: T,
    than rhs: T,
    by keypath0: KeyPath<T, P0>,
    _ keypath1: KeyPath<T, P1>,
    _ keypath2: KeyPath<T, P2>
) -> Bool
    where
        P0: Comparable,
        P1: Comparable,
        P2: Comparable
{
    isLess(rhs, than: lhs, by: keypath0, keypath1, keypath2)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given keypaths.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c, \.d)
///
public func isGreater<T, P0, P1, P2, P3>(
    _ lhs: T,
    than rhs: T,
    by keypath0: KeyPath<T, P0>,
    _ keypath1: KeyPath<T, P1>,
    _ keypath2: KeyPath<T, P2>,
    _ keypath3: KeyPath<T, P3>
) -> Bool
    where
        P0: Comparable,
        P1: Comparable,
        P2: Comparable,
        P3: Comparable
{
    isLess(rhs, than: lhs, by: keypath0, keypath1, keypath2, keypath3)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given keypaths.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e)
///
public func isGreater<T, P0, P1, P2, P3, P4>(
    _ lhs: T,
    than rhs: T,
    by keypath0: KeyPath<T, P0>,
    _ keypath1: KeyPath<T, P1>,
    _ keypath2: KeyPath<T, P2>,
    _ keypath3: KeyPath<T, P3>,
    _ keypath4: KeyPath<T, P4>
) -> Bool
    where
        P0: Comparable,
        P1: Comparable,
        P2: Comparable,
        P3: Comparable,
        P4: Comparable
{
    isLess(rhs, than: lhs, by: keypath0, keypath1, keypath2, keypath3, keypath4)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given keypaths.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f)
///
public func isGreater<T, P0, P1, P2, P3, P4, P5>(
    _ lhs: T,
    than rhs: T,
    by keypath0: KeyPath<T, P0>,
    _ keypath1: KeyPath<T, P1>,
    _ keypath2: KeyPath<T, P2>,
    _ keypath3: KeyPath<T, P3>,
    _ keypath4: KeyPath<T, P4>,
    _ keypath5: KeyPath<T, P5>
) -> Bool
    where
        P0: Comparable,
        P1: Comparable,
        P2: Comparable,
        P3: Comparable,
        P4: Comparable,
        P5: Comparable
{
    isLess(rhs, than: lhs, by: keypath0, keypath1, keypath2, keypath3, keypath4, keypath5)
}
