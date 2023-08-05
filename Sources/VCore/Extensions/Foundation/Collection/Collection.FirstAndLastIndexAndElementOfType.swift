//
//  Collection.FirstAndLastIndexAndElementOfType.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 05.08.23.
//

import Foundation

// MARK: - Collection First Index and Element of Type
extension Collection {
    /// Returns first index and element of `Collection` that is a type `T`.
    ///
    /// Used for avoiding accessing both index and element with built-in methods.
    ///
    /// In the following example, `p1` and `p2` are equivalent.
    ///
    ///     protocol P {}
    ///
    ///     struct S: P {}
    ///
    ///     let array: [any P] = [S()]
    ///
    ///     let p1: S? = array.first { $0 is S } as? S
    ///     guard let (index2, p2): (Int, S) = array.firstIndexAndElement(ofType: S.self) else { return }
    ///
    public func firstIndexAndElement<T>(
        ofType type: T.Type,
        where predicate: ((T) throws -> Bool)? = nil
    ) rethrows -> (index: Index, element: T)? {
        guard
            let index: Index = try firstIndex(ofType: type, where: predicate),
            let element: T = self[index] as? T
        else {
            return nil
        }

        return (index, element)
    }
}

// MARK: - Bidirectional Collection Last Index and Element of Type
extension BidirectionalCollection {
    /// Returns last index and element of `Collection` that is a type `T`.
    ///
    /// Used for avoiding accessing both index and element with built-in methods.
    ///
    /// In the following example, `p1` and `p2` are equivalent.
    ///
    ///     protocol P {}
    ///
    ///     struct S: P {}
    ///
    ///     let array: [any P] = [S()]
    ///
    ///     let p1: S? = array.last { $0 is S } as? S
    ///     guard let (index2, p2): (Int, S) = array.lastIndexAndElement(ofType: S.self) else { return }
    ///
    public func lastIndexAndElement<T>(
        ofType type: T.Type,
        where predicate: ((T) throws -> Bool)? = nil
    ) rethrows -> (index: Index, element: T)? {
        guard
            let index: Index = try lastIndex(ofType: type, where: predicate),
            let element: T = self[index] as? T
        else {
            return nil
        }

        return (index, element)
    }
}
