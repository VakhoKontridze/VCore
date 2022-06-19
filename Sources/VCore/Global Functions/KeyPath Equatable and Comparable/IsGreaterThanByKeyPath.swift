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
public func isGreater<T>(
    _ lhs: T,
    than rhs: T,
    by keypath0: KeyPath<T, some Comparable>
) -> Bool {
    isLess(rhs, than: lhs, by: keypath0)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given keypaths.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b)
///
public func isGreater<T>(
    _ lhs: T,
    than rhs: T,
    by keypath0: KeyPath<T, some Comparable>,
    _ keypath1: KeyPath<T, some Comparable>
) -> Bool {
    isLess(rhs, than: lhs, by: keypath0, keypath1)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given keypaths.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c)
///
public func isGreater<T>(
    _ lhs: T,
    than rhs: T,
    by keypath0: KeyPath<T, some Comparable>,
    _ keypath1: KeyPath<T, some Comparable>,
    _ keypath2: KeyPath<T, some Comparable>
) -> Bool {
    isLess(rhs, than: lhs, by: keypath0, keypath1, keypath2)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given keypaths.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c, \.d)
///
public func isGreater<T>(
    _ lhs: T,
    than rhs: T,
    by keypath0: KeyPath<T, some Comparable>,
    _ keypath1: KeyPath<T, some Comparable>,
    _ keypath2: KeyPath<T, some Comparable>,
    _ keypath3: KeyPath<T, some Comparable>
) -> Bool {
    isLess(rhs, than: lhs, by: keypath0, keypath1, keypath2, keypath3)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given keypaths.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e)
///
public func isGreater<T>(
    _ lhs: T,
    than rhs: T,
    by keypath0: KeyPath<T, some Comparable>,
    _ keypath1: KeyPath<T, some Comparable>,
    _ keypath2: KeyPath<T, some Comparable>,
    _ keypath3: KeyPath<T, some Comparable>,
    _ keypath4: KeyPath<T, some Comparable>
) -> Bool {
    isLess(rhs, than: lhs, by: keypath0, keypath1, keypath2, keypath3, keypath4)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given keypaths.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f)
///
public func isGreater<T>(
    _ lhs: T,
    than rhs: T,
    by keypath0: KeyPath<T, some Comparable>,
    _ keypath1: KeyPath<T, some Comparable>,
    _ keypath2: KeyPath<T, some Comparable>,
    _ keypath3: KeyPath<T, some Comparable>,
    _ keypath4: KeyPath<T, some Comparable>,
    _ keypath5: KeyPath<T, some Comparable>
) -> Bool {
    isLess(rhs, than: lhs, by: keypath0, keypath1, keypath2, keypath3, keypath4, keypath5)
}
