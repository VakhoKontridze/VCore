//
//  IsLessThanByKeyPath.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 18.06.22.
//

import Foundation

// MARK: - Is Less than by KeyPath
/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given keypaths.
///
///     isLess(objectA, than: objectB, by: \.a)
///
public func isLess<T>(
    _ lhs: T,
    than rhs: T,
    by keypath0: KeyPath<T, some Comparable>
) -> Bool {
    lhs[keyPath: keypath0] <
    rhs[keyPath: keypath0]
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given keypaths.
///
///     isLess(objectA, than: objectB, by: \.a, \.b)
///
public func isLess<T>(
    _ lhs: T,
    than rhs: T,
    by keypath0: KeyPath<T, some Comparable>,
    _ keypath1: KeyPath<T, some Comparable>
) -> Bool {
    (lhs[keyPath: keypath0], lhs[keyPath: keypath1]) <
    (rhs[keyPath: keypath0], rhs[keyPath: keypath1])
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given keypaths.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c)
///
public func isLess<T>(
    _ lhs: T,
    than rhs: T,
    by keypath0: KeyPath<T, some Comparable>,
    _ keypath1: KeyPath<T, some Comparable>,
    _ keypath2: KeyPath<T, some Comparable>
) -> Bool {
    (lhs[keyPath: keypath0], lhs[keyPath: keypath1], lhs[keyPath: keypath2]) <
    (rhs[keyPath: keypath0], rhs[keyPath: keypath1], rhs[keyPath: keypath2])
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given keypaths.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c, \.d)
///
public func isLess<T>(
    _ lhs: T,
    than rhs: T,
    by keypath0: KeyPath<T, some Comparable>,
    _ keypath1: KeyPath<T, some Comparable>,
    _ keypath2: KeyPath<T, some Comparable>,
    _ keypath3: KeyPath<T, some Comparable>
) -> Bool {
    (lhs[keyPath: keypath0], lhs[keyPath: keypath1], lhs[keyPath: keypath2], lhs[keyPath: keypath3]) <
    (rhs[keyPath: keypath0], rhs[keyPath: keypath1], rhs[keyPath: keypath2], rhs[keyPath: keypath3])
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given keypaths.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e)
///
public func isLess<T>(
    _ lhs: T,
    than rhs: T,
    by keypath0: KeyPath<T, some Comparable>,
    _ keypath1: KeyPath<T, some Comparable>,
    _ keypath2: KeyPath<T, some Comparable>,
    _ keypath3: KeyPath<T, some Comparable>,
    _ keypath4: KeyPath<T, some Comparable>
) -> Bool {
    (lhs[keyPath: keypath0], lhs[keyPath: keypath1], lhs[keyPath: keypath2], lhs[keyPath: keypath3], lhs[keyPath: keypath4]) <
    (rhs[keyPath: keypath0], rhs[keyPath: keypath1], rhs[keyPath: keypath2], rhs[keyPath: keypath3], rhs[keyPath: keypath4])
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given keypaths.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f)
///
public func isLess<T>(
    _ lhs: T,
    than rhs: T,
    by keypath0: KeyPath<T, some Comparable>,
    _ keypath1: KeyPath<T, some Comparable>,
    _ keypath2: KeyPath<T, some Comparable>,
    _ keypath3: KeyPath<T, some Comparable>,
    _ keypath4: KeyPath<T, some Comparable>,
    _ keypath5: KeyPath<T, some Comparable>
) -> Bool {
    (lhs[keyPath: keypath0], lhs[keyPath: keypath1], lhs[keyPath: keypath2], lhs[keyPath: keypath3], lhs[keyPath: keypath4], lhs[keyPath: keypath5]) <
    (rhs[keyPath: keypath0], rhs[keyPath: keypath1], rhs[keyPath: keypath2], rhs[keyPath: keypath3], rhs[keyPath: keypath4], rhs[keyPath: keypath5])
}
