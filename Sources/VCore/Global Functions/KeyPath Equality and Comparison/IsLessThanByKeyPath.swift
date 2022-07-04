//
//  IsLessThanByKeyPath.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 18.06.22.
//

import Foundation

// MARK: - Is Less than by KeyPath
/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`s.
///
///     isLess(objectA, than: objectB, by: \.a)
///
public func isLess<T, P0>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, P0>
) -> Bool
    where
        P0: Comparable
{
    lhs[keyPath: keyPath0] <
    rhs[keyPath: keyPath0]
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b)
///
public func isLess<T, P0, P1>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, P0>,
    _ keyPath1: KeyPath<T, P1>
) -> Bool
    where
        P0: Comparable,
        P1: Comparable
{
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1]) <
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1])
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c)
///
public func isLess<T, P0, P1, P2>(
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
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1], lhs[keyPath: keyPath2]) <
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1], rhs[keyPath: keyPath2])
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c, \.d)
///
public func isLess<T, P0, P1, P2, P3>(
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
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1], lhs[keyPath: keyPath2], lhs[keyPath: keyPath3]) <
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1], rhs[keyPath: keyPath2], rhs[keyPath: keyPath3])
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e)
///
public func isLess<T, P0, P1, P2, P3, P4>(
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
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1], lhs[keyPath: keyPath2], lhs[keyPath: keyPath3], lhs[keyPath: keyPath4]) <
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1], rhs[keyPath: keyPath2], rhs[keyPath: keyPath3], rhs[keyPath: keyPath4])
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f)
///
public func isLess<T, P0, P1, P2, P3, P4, P5>(
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
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1], lhs[keyPath: keyPath2], lhs[keyPath: keyPath3], lhs[keyPath: keyPath4], lhs[keyPath: keyPath5]) <
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1], rhs[keyPath: keyPath2], rhs[keyPath: keyPath3], rhs[keyPath: keyPath4], rhs[keyPath: keyPath5])
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f, \.g)
///
public func isLess<T, P0, P1, P2, P3, P4, P5, P6>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, P0>,
    _ keyPath1: KeyPath<T, P1>,
    _ keyPath2: KeyPath<T, P2>,
    _ keyPath3: KeyPath<T, P3>,
    _ keyPath4: KeyPath<T, P4>,
    _ keyPath5: KeyPath<T, P5>,
    _ keyPath6: KeyPath<T, P6>
) -> Bool
    where
        P0: Comparable,
        P1: Comparable,
        P2: Comparable,
        P3: Comparable,
        P4: Comparable,
        P5: Comparable,
        P6: Comparable
{
    if lhs[keyPath: keyPath0] != rhs[keyPath: keyPath0] { return lhs[keyPath: keyPath0] < rhs[keyPath: keyPath0] }
    else if lhs[keyPath: keyPath1] != rhs[keyPath: keyPath1] { return lhs[keyPath: keyPath1] < rhs[keyPath: keyPath1] }
    else if lhs[keyPath: keyPath2] != rhs[keyPath: keyPath2] { return lhs[keyPath: keyPath2] < rhs[keyPath: keyPath2] }
    else if lhs[keyPath: keyPath3] != rhs[keyPath: keyPath3] { return lhs[keyPath: keyPath3] < rhs[keyPath: keyPath3] }
    else if lhs[keyPath: keyPath4] != rhs[keyPath: keyPath4] { return lhs[keyPath: keyPath4] < rhs[keyPath: keyPath4] }
    else if lhs[keyPath: keyPath5] != rhs[keyPath: keyPath5] { return lhs[keyPath: keyPath5] < rhs[keyPath: keyPath5] }
    else if lhs[keyPath: keyPath6] != rhs[keyPath: keyPath6] { return lhs[keyPath: keyPath6] < rhs[keyPath: keyPath6] }
    return false
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h)
///
public func isLess<T, P0, P1, P2, P3, P4, P5, P6, P7>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, P0>,
    _ keyPath1: KeyPath<T, P1>,
    _ keyPath2: KeyPath<T, P2>,
    _ keyPath3: KeyPath<T, P3>,
    _ keyPath4: KeyPath<T, P4>,
    _ keyPath5: KeyPath<T, P5>,
    _ keyPath6: KeyPath<T, P6>,
    _ keyPath7: KeyPath<T, P7>
) -> Bool
    where
        P0: Comparable,
        P1: Comparable,
        P2: Comparable,
        P3: Comparable,
        P4: Comparable,
        P5: Comparable,
        P6: Comparable,
        P7: Comparable
{
    if lhs[keyPath: keyPath0] != rhs[keyPath: keyPath0] { return lhs[keyPath: keyPath0] < rhs[keyPath: keyPath0] }
    else if lhs[keyPath: keyPath1] != rhs[keyPath: keyPath1] { return lhs[keyPath: keyPath1] < rhs[keyPath: keyPath1] }
    else if lhs[keyPath: keyPath2] != rhs[keyPath: keyPath2] { return lhs[keyPath: keyPath2] < rhs[keyPath: keyPath2] }
    else if lhs[keyPath: keyPath3] != rhs[keyPath: keyPath3] { return lhs[keyPath: keyPath3] < rhs[keyPath: keyPath3] }
    else if lhs[keyPath: keyPath4] != rhs[keyPath: keyPath4] { return lhs[keyPath: keyPath4] < rhs[keyPath: keyPath4] }
    else if lhs[keyPath: keyPath5] != rhs[keyPath: keyPath5] { return lhs[keyPath: keyPath5] < rhs[keyPath: keyPath5] }
    else if lhs[keyPath: keyPath6] != rhs[keyPath: keyPath6] { return lhs[keyPath: keyPath6] < rhs[keyPath: keyPath6] }
    else if lhs[keyPath: keyPath7] != rhs[keyPath: keyPath7] { return lhs[keyPath: keyPath7] < rhs[keyPath: keyPath7] }
    return false
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i)
///
public func isLess<T, P0, P1, P2, P3, P4, P5, P6, P7, P8>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, P0>,
    _ keyPath1: KeyPath<T, P1>,
    _ keyPath2: KeyPath<T, P2>,
    _ keyPath3: KeyPath<T, P3>,
    _ keyPath4: KeyPath<T, P4>,
    _ keyPath5: KeyPath<T, P5>,
    _ keyPath6: KeyPath<T, P6>,
    _ keyPath7: KeyPath<T, P7>,
    _ keyPath8: KeyPath<T, P8>
) -> Bool
    where
        P0: Comparable,
        P1: Comparable,
        P2: Comparable,
        P3: Comparable,
        P4: Comparable,
        P5: Comparable,
        P6: Comparable,
        P7: Comparable,
        P8: Comparable
{
    if lhs[keyPath: keyPath0] != rhs[keyPath: keyPath0] { return lhs[keyPath: keyPath0] < rhs[keyPath: keyPath0] }
    else if lhs[keyPath: keyPath1] != rhs[keyPath: keyPath1] { return lhs[keyPath: keyPath1] < rhs[keyPath: keyPath1] }
    else if lhs[keyPath: keyPath2] != rhs[keyPath: keyPath2] { return lhs[keyPath: keyPath2] < rhs[keyPath: keyPath2] }
    else if lhs[keyPath: keyPath3] != rhs[keyPath: keyPath3] { return lhs[keyPath: keyPath3] < rhs[keyPath: keyPath3] }
    else if lhs[keyPath: keyPath4] != rhs[keyPath: keyPath4] { return lhs[keyPath: keyPath4] < rhs[keyPath: keyPath4] }
    else if lhs[keyPath: keyPath5] != rhs[keyPath: keyPath5] { return lhs[keyPath: keyPath5] < rhs[keyPath: keyPath5] }
    else if lhs[keyPath: keyPath6] != rhs[keyPath: keyPath6] { return lhs[keyPath: keyPath6] < rhs[keyPath: keyPath6] }
    else if lhs[keyPath: keyPath7] != rhs[keyPath: keyPath7] { return lhs[keyPath: keyPath7] < rhs[keyPath: keyPath7] }
    else if lhs[keyPath: keyPath8] != rhs[keyPath: keyPath8] { return lhs[keyPath: keyPath8] < rhs[keyPath: keyPath8] }
    return false
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i, \.j)
///
public func isLess<T, P0, P1, P2, P3, P4, P5, P6, P7, P8, P9>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, P0>,
    _ keyPath1: KeyPath<T, P1>,
    _ keyPath2: KeyPath<T, P2>,
    _ keyPath3: KeyPath<T, P3>,
    _ keyPath4: KeyPath<T, P4>,
    _ keyPath5: KeyPath<T, P5>,
    _ keyPath6: KeyPath<T, P6>,
    _ keyPath7: KeyPath<T, P7>,
    _ keyPath8: KeyPath<T, P8>,
    _ keyPath9: KeyPath<T, P9>
) -> Bool
    where
        P0: Comparable,
        P1: Comparable,
        P2: Comparable,
        P3: Comparable,
        P4: Comparable,
        P5: Comparable,
        P6: Comparable,
        P7: Comparable,
        P8: Comparable,
        P9: Comparable
{
    if lhs[keyPath: keyPath0] != rhs[keyPath: keyPath0] { return lhs[keyPath: keyPath0] < rhs[keyPath: keyPath0] }
    else if lhs[keyPath: keyPath1] != rhs[keyPath: keyPath1] { return lhs[keyPath: keyPath1] < rhs[keyPath: keyPath1] }
    else if lhs[keyPath: keyPath2] != rhs[keyPath: keyPath2] { return lhs[keyPath: keyPath2] < rhs[keyPath: keyPath2] }
    else if lhs[keyPath: keyPath3] != rhs[keyPath: keyPath3] { return lhs[keyPath: keyPath3] < rhs[keyPath: keyPath3] }
    else if lhs[keyPath: keyPath4] != rhs[keyPath: keyPath4] { return lhs[keyPath: keyPath4] < rhs[keyPath: keyPath4] }
    else if lhs[keyPath: keyPath5] != rhs[keyPath: keyPath5] { return lhs[keyPath: keyPath5] < rhs[keyPath: keyPath5] }
    else if lhs[keyPath: keyPath6] != rhs[keyPath: keyPath6] { return lhs[keyPath: keyPath6] < rhs[keyPath: keyPath6] }
    else if lhs[keyPath: keyPath7] != rhs[keyPath: keyPath7] { return lhs[keyPath: keyPath7] < rhs[keyPath: keyPath7] }
    else if lhs[keyPath: keyPath8] != rhs[keyPath: keyPath8] { return lhs[keyPath: keyPath8] < rhs[keyPath: keyPath8] }
    else if lhs[keyPath: keyPath9] != rhs[keyPath: keyPath9] { return lhs[keyPath: keyPath9] < rhs[keyPath: keyPath9] }
    return false
}
