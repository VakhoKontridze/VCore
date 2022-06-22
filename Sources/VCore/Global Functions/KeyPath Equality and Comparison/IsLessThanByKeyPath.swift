//
//  IsLessThanByKeyPath.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 18.06.22.
//

import Foundation

// MARK: - Is Less than by KeyPath
/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`'s.
///
///     isLess(objectA, than: objectB, by: \.a)
///
public func isLess<T>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, some Comparable>
) -> Bool {
    lhs[keyPath: keyPath0] <
    rhs[keyPath: keyPath0]
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`'s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b)
///
public func isLess<T>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, some Comparable>,
    _ keyPath1: KeyPath<T, some Comparable>
) -> Bool {
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1]) <
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1])
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`'s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c)
///
public func isLess<T>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, some Comparable>,
    _ keyPath1: KeyPath<T, some Comparable>,
    _ keyPath2: KeyPath<T, some Comparable>
) -> Bool {
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1], lhs[keyPath: keyPath2]) <
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1], rhs[keyPath: keyPath2])
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`'s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c, \.d)
///
public func isLess<T>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, some Comparable>,
    _ keyPath1: KeyPath<T, some Comparable>,
    _ keyPath2: KeyPath<T, some Comparable>,
    _ keyPath3: KeyPath<T, some Comparable>
) -> Bool {
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1], lhs[keyPath: keyPath2], lhs[keyPath: keyPath3]) <
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1], rhs[keyPath: keyPath2], rhs[keyPath: keyPath3])
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`'s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e)
///
public func isLess<T>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, some Comparable>,
    _ keyPath1: KeyPath<T, some Comparable>,
    _ keyPath2: KeyPath<T, some Comparable>,
    _ keyPath3: KeyPath<T, some Comparable>,
    _ keyPath4: KeyPath<T, some Comparable>
) -> Bool {
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1], lhs[keyPath: keyPath2], lhs[keyPath: keyPath3], lhs[keyPath: keyPath4]) <
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1], rhs[keyPath: keyPath2], rhs[keyPath: keyPath3], rhs[keyPath: keyPath4])
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`'s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f)
///
public func isLess<T>(
    _ lhs: T,
    than rhs: T,
    by keyPath0: KeyPath<T, some Comparable>,
    _ keyPath1: KeyPath<T, some Comparable>,
    _ keyPath2: KeyPath<T, some Comparable>,
    _ keyPath3: KeyPath<T, some Comparable>,
    _ keyPath4: KeyPath<T, some Comparable>,
    _ keyPath5: KeyPath<T, some Comparable>
) -> Bool {
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1], lhs[keyPath: keyPath2], lhs[keyPath: keyPath3], lhs[keyPath: keyPath4], lhs[keyPath: keyPath5]) <
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1], rhs[keyPath: keyPath2], rhs[keyPath: keyPath3], rhs[keyPath: keyPath4], rhs[keyPath: keyPath5])
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`'s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f, \.g)
///
public func isLess<T>(
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
    if lhs[keyPath: keyPath0] != rhs[keyPath: keyPath0] { return lhs[keyPath: keyPath0] < rhs[keyPath: keyPath0] }
    else if lhs[keyPath: keyPath1] != rhs[keyPath: keyPath1] { return lhs[keyPath: keyPath1] < rhs[keyPath: keyPath1] }
    else if lhs[keyPath: keyPath2] != rhs[keyPath: keyPath2] { return lhs[keyPath: keyPath2] < rhs[keyPath: keyPath2] }
    else if lhs[keyPath: keyPath3] != rhs[keyPath: keyPath3] { return lhs[keyPath: keyPath3] < rhs[keyPath: keyPath3] }
    else if lhs[keyPath: keyPath4] != rhs[keyPath: keyPath4] { return lhs[keyPath: keyPath4] < rhs[keyPath: keyPath4] }
    else if lhs[keyPath: keyPath5] != rhs[keyPath: keyPath5] { return lhs[keyPath: keyPath5] < rhs[keyPath: keyPath5] }
    else if lhs[keyPath: keyPath6] != rhs[keyPath: keyPath6] { return lhs[keyPath: keyPath6] < rhs[keyPath: keyPath6] }
    return false
}

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`'s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h)
///
public func isLess<T>(
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

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`'s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i)
///
public func isLess<T>(
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

/// Returns a `Bool` value indicating whether the value of the first argument is less than that of the second argument with given `KeyPath`'s.
///
///     isLess(objectA, than: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i, \.j)
///
public func isLess<T>(
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
