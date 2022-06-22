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
public func isEqual<T>(
    _ lhs: T,
    to rhs: T,
    by keyPath0: KeyPath<T, some Equatable>
) -> Bool {
    lhs[keyPath: keyPath0] ==
    rhs[keyPath: keyPath0]
}

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given `KeyPath`'s.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b)
///
public func isEqual<T>(
    _ lhs: T,
    to rhs: T,
    by keyPath0: KeyPath<T, some Equatable>,
    _ keyPath1: KeyPath<T, some Equatable>
) -> Bool {
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1]) ==
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1])
}

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given `KeyPath`'s.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b, \.c)
///
public func isEqual<T>(
    _ lhs: T,
    to rhs: T,
    by keyPath0: KeyPath<T, some Equatable>,
    _ keyPath1: KeyPath<T, some Equatable>,
    _ keyPath2: KeyPath<T, some Equatable>
) -> Bool {
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1], lhs[keyPath: keyPath2]) ==
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1], rhs[keyPath: keyPath2])
}

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given `KeyPath`'s.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b, \.c, \.d)
///
public func isEqual<T>(
    _ lhs: T,
    to rhs: T,
    by keyPath0: KeyPath<T, some Equatable>,
    _ keyPath1: KeyPath<T, some Equatable>,
    _ keyPath2: KeyPath<T, some Equatable>,
    _ keyPath3: KeyPath<T, some Equatable>
) -> Bool {
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1], lhs[keyPath: keyPath2], lhs[keyPath: keyPath3]) ==
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1], rhs[keyPath: keyPath2], rhs[keyPath: keyPath3])
}

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given `KeyPath`'s.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b, \.c, \.d, \.e)
///
public func isEqual<T>(
    _ lhs: T,
    to rhs: T,
    by keyPath0: KeyPath<T, some Equatable>,
    _ keyPath1: KeyPath<T, some Equatable>,
    _ keyPath2: KeyPath<T, some Equatable>,
    _ keyPath3: KeyPath<T, some Equatable>,
    _ keyPath4: KeyPath<T, some Equatable>
) -> Bool {
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1], lhs[keyPath: keyPath2], lhs[keyPath: keyPath3], lhs[keyPath: keyPath4]) ==
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1], rhs[keyPath: keyPath2], rhs[keyPath: keyPath3], rhs[keyPath: keyPath4])
}

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given `KeyPath`'s.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f)
///
public func isEqual<T>(
    _ lhs: T,
    to rhs: T,
    by keyPath0: KeyPath<T, some Equatable>,
    _ keyPath1: KeyPath<T, some Equatable>,
    _ keyPath2: KeyPath<T, some Equatable>,
    _ keyPath3: KeyPath<T, some Equatable>,
    _ keyPath4: KeyPath<T, some Equatable>,
    _ keyPath5: KeyPath<T, some Equatable>
) -> Bool {
    (lhs[keyPath: keyPath0], lhs[keyPath: keyPath1], lhs[keyPath: keyPath2], lhs[keyPath: keyPath3], lhs[keyPath: keyPath4], lhs[keyPath: keyPath5]) ==
    (rhs[keyPath: keyPath0], rhs[keyPath: keyPath1], rhs[keyPath: keyPath2], rhs[keyPath: keyPath3], rhs[keyPath: keyPath4], rhs[keyPath: keyPath5])
}

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given `KeyPath`'s.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f, \.g)
///
public func isEqual<T>(
    _ lhs: T,
    to rhs: T,
    by keyPath0: KeyPath<T, some Equatable>,
    _ keyPath1: KeyPath<T, some Equatable>,
    _ keyPath2: KeyPath<T, some Equatable>,
    _ keyPath3: KeyPath<T, some Equatable>,
    _ keyPath4: KeyPath<T, some Equatable>,
    _ keyPath5: KeyPath<T, some Equatable>,
    _ keyPath6: KeyPath<T, some Equatable>
) -> Bool {
    lhs[keyPath: keyPath0] == rhs[keyPath: keyPath0] &&
    lhs[keyPath: keyPath1] == rhs[keyPath: keyPath1] &&
    lhs[keyPath: keyPath2] == rhs[keyPath: keyPath2] &&
    lhs[keyPath: keyPath3] == rhs[keyPath: keyPath3] &&
    lhs[keyPath: keyPath4] == rhs[keyPath: keyPath4] &&
    lhs[keyPath: keyPath5] == rhs[keyPath: keyPath5] &&
    lhs[keyPath: keyPath6] == rhs[keyPath: keyPath6]
}

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given `KeyPath`'s.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h)
///
public func isEqual<T>(
    _ lhs: T,
    to rhs: T,
    by keyPath0: KeyPath<T, some Equatable>,
    _ keyPath1: KeyPath<T, some Equatable>,
    _ keyPath2: KeyPath<T, some Equatable>,
    _ keyPath3: KeyPath<T, some Equatable>,
    _ keyPath4: KeyPath<T, some Equatable>,
    _ keyPath5: KeyPath<T, some Equatable>,
    _ keyPath6: KeyPath<T, some Equatable>,
    _ keyPath7: KeyPath<T, some Equatable>
) -> Bool {
    lhs[keyPath: keyPath0] == rhs[keyPath: keyPath0] &&
    lhs[keyPath: keyPath1] == rhs[keyPath: keyPath1] &&
    lhs[keyPath: keyPath2] == rhs[keyPath: keyPath2] &&
    lhs[keyPath: keyPath3] == rhs[keyPath: keyPath3] &&
    lhs[keyPath: keyPath4] == rhs[keyPath: keyPath4] &&
    lhs[keyPath: keyPath5] == rhs[keyPath: keyPath5] &&
    lhs[keyPath: keyPath6] == rhs[keyPath: keyPath6] &&
    lhs[keyPath: keyPath7] == rhs[keyPath: keyPath7]
}

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given `KeyPath`'s.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i)
///
public func isEqual<T>(
    _ lhs: T,
    to rhs: T,
    by keyPath0: KeyPath<T, some Equatable>,
    _ keyPath1: KeyPath<T, some Equatable>,
    _ keyPath2: KeyPath<T, some Equatable>,
    _ keyPath3: KeyPath<T, some Equatable>,
    _ keyPath4: KeyPath<T, some Equatable>,
    _ keyPath5: KeyPath<T, some Equatable>,
    _ keyPath6: KeyPath<T, some Equatable>,
    _ keyPath7: KeyPath<T, some Equatable>,
    _ keyPath8: KeyPath<T, some Equatable>
) -> Bool {
    lhs[keyPath: keyPath0] == rhs[keyPath: keyPath0] &&
    lhs[keyPath: keyPath1] == rhs[keyPath: keyPath1] &&
    lhs[keyPath: keyPath2] == rhs[keyPath: keyPath2] &&
    lhs[keyPath: keyPath3] == rhs[keyPath: keyPath3] &&
    lhs[keyPath: keyPath4] == rhs[keyPath: keyPath4] &&
    lhs[keyPath: keyPath5] == rhs[keyPath: keyPath5] &&
    lhs[keyPath: keyPath6] == rhs[keyPath: keyPath6] &&
    lhs[keyPath: keyPath7] == rhs[keyPath: keyPath7] &&
    lhs[keyPath: keyPath8] == rhs[keyPath: keyPath8]
}

/// Returns a `Bool` value indicating whether the value of the first argument is equal to that of the second argument with given `KeyPath`'s.
///
///     isEqual(objectA, to: objectB, by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i, \.j)
///
public func isEqual<T>(
    _ lhs: T,
    to rhs: T,
    by keyPath0: KeyPath<T, some Equatable>,
    _ keyPath1: KeyPath<T, some Equatable>,
    _ keyPath2: KeyPath<T, some Equatable>,
    _ keyPath3: KeyPath<T, some Equatable>,
    _ keyPath4: KeyPath<T, some Equatable>,
    _ keyPath5: KeyPath<T, some Equatable>,
    _ keyPath6: KeyPath<T, some Equatable>,
    _ keyPath7: KeyPath<T, some Equatable>,
    _ keyPath8: KeyPath<T, some Equatable>,
    _ keyPath9: KeyPath<T, some Equatable>
) -> Bool {
    lhs[keyPath: keyPath0] == rhs[keyPath: keyPath0] &&
    lhs[keyPath: keyPath1] == rhs[keyPath: keyPath1] &&
    lhs[keyPath: keyPath2] == rhs[keyPath: keyPath2] &&
    lhs[keyPath: keyPath3] == rhs[keyPath: keyPath3] &&
    lhs[keyPath: keyPath4] == rhs[keyPath: keyPath4] &&
    lhs[keyPath: keyPath5] == rhs[keyPath: keyPath5] &&
    lhs[keyPath: keyPath6] == rhs[keyPath: keyPath6] &&
    lhs[keyPath: keyPath7] == rhs[keyPath: keyPath7] &&
    lhs[keyPath: keyPath8] == rhs[keyPath: keyPath8] &&
    lhs[keyPath: keyPath9] == rhs[keyPath: keyPath9]
}
