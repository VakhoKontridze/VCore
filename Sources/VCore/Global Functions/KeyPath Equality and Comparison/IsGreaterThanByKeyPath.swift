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
public func isGreater<T>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, some Comparable>
) -> Bool {
    isLess(rhs, than: lhs, by: keyPath0)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given `KeyPath`'s.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b)
///
public func isGreater<T>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, some Comparable>,
    _ keyPath1: KeyPath<T, some Comparable>
) -> Bool {
    isLess(rhs, than: lhs, by: keyPath0, keyPath1)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given `KeyPath`'s.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c)
///
public func isGreater<T>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, some Comparable>,
    _ keyPath1: KeyPath<T, some Comparable>,
    _ keyPath2: KeyPath<T, some Comparable>
) -> Bool {
    isLess(rhs, than: lhs, by: keyPath0, keyPath1, keyPath2)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given `KeyPath`'s.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c, \.d)
///
public func isGreater<T>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, some Comparable>,
    _ keyPath1: KeyPath<T, some Comparable>,
    _ keyPath2: KeyPath<T, some Comparable>,
    _ keyPath3: KeyPath<T, some Comparable>
) -> Bool {
    isLess(rhs, than: lhs, by: keyPath0, keyPath1, keyPath2, keyPath3)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given `KeyPath`'s.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e)
///
public func isGreater<T>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, some Comparable>,
    _ keyPath1: KeyPath<T, some Comparable>,
    _ keyPath2: KeyPath<T, some Comparable>,
    _ keyPath3: KeyPath<T, some Comparable>,
    _ keyPath4: KeyPath<T, some Comparable>
) -> Bool {
    isLess(rhs, than: lhs, by: keyPath0, keyPath1, keyPath2, keyPath3, keyPath4)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given `KeyPath`'s.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f)
///
public func isGreater<T>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, some Comparable>,
    _ keyPath1: KeyPath<T, some Comparable>,
    _ keyPath2: KeyPath<T, some Comparable>,
    _ keyPath3: KeyPath<T, some Comparable>,
    _ keyPath4: KeyPath<T, some Comparable>,
    _ keyPath5: KeyPath<T, some Comparable>
) -> Bool {
    isLess(rhs, than: lhs, by: keyPath0, keyPath1, keyPath2, keyPath3, keyPath4, keyPath5)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given `KeyPath`'s.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f, \.g)
///
public func isGreater<T>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, some Comparable>,
    _ keyPath1: KeyPath<T, some Comparable>,
    _ keyPath2: KeyPath<T, some Comparable>,
    _ keyPath3: KeyPath<T, some Comparable>,
    _ keyPath4: KeyPath<T, some Comparable>,
    _ keyPath5: KeyPath<T, some Comparable>,
    _ keyPath6: KeyPath<T, some Comparable>
) -> Bool {
    isLess(rhs, than: lhs, by: keyPath0, keyPath1, keyPath2, keyPath3, keyPath4, keyPath5, keyPath6)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given `KeyPath`'s.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f, \.g \.h)
///
public func isGreater<T>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, some Comparable>,
    _ keyPath1: KeyPath<T, some Comparable>,
    _ keyPath2: KeyPath<T, some Comparable>,
    _ keyPath3: KeyPath<T, some Comparable>,
    _ keyPath4: KeyPath<T, some Comparable>,
    _ keyPath5: KeyPath<T, some Comparable>,
    _ keyPath6: KeyPath<T, some Comparable>,
    _ keyPath7: KeyPath<T, some Comparable>
) -> Bool {
    isLess(rhs, than: lhs, by: keyPath0, keyPath1, keyPath2, keyPath3, keyPath4, keyPath5, keyPath6, keyPath7)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given `KeyPath`'s.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f, \.g \.h, \.i)
///
public func isGreater<T>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, some Comparable>,
    _ keyPath1: KeyPath<T, some Comparable>,
    _ keyPath2: KeyPath<T, some Comparable>,
    _ keyPath3: KeyPath<T, some Comparable>,
    _ keyPath4: KeyPath<T, some Comparable>,
    _ keyPath5: KeyPath<T, some Comparable>,
    _ keyPath6: KeyPath<T, some Comparable>,
    _ keyPath7: KeyPath<T, some Comparable>,
    _ keyPath8: KeyPath<T, some Comparable>
) -> Bool {
    isLess(rhs, than: lhs, by: keyPath0, keyPath1, keyPath2, keyPath3, keyPath4, keyPath5, keyPath6, keyPath7, keyPath8)
}

/// Returns a `Bool` value indicating whether the value of the first argument is greater than that of the second argument with given `KeyPath`'s.
///
///     isGreater(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f, \.g \.h, \.i, \.j)
///
public func isGreater<T>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, some Comparable>,
    _ keyPath1: KeyPath<T, some Comparable>,
    _ keyPath2: KeyPath<T, some Comparable>,
    _ keyPath3: KeyPath<T, some Comparable>,
    _ keyPath4: KeyPath<T, some Comparable>,
    _ keyPath5: KeyPath<T, some Comparable>,
    _ keyPath6: KeyPath<T, some Comparable>,
    _ keyPath7: KeyPath<T, some Comparable>,
    _ keyPath8: KeyPath<T, some Comparable>,
    _ keyPath9: KeyPath<T, some Comparable>
) -> Bool {
    isLess(rhs, than: lhs, by: keyPath0, keyPath1, keyPath2, keyPath3, keyPath4, keyPath5, keyPath6, keyPath7, keyPath8, keyPath9)
}
