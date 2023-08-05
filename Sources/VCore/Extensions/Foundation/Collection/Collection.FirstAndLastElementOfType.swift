//
//  Collection.FirstAndLastElement.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.11.22.
//

import Foundation

// MARK: - Collection First Element of Type
extension Collection {
    /// Returns the first element of `Collection`that is a type `T`.
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
    ///     let p2: S? = array.firstElement(ofType: S.self)
    ///
    public func firstElement<T>(
        ofType type: T.Type,
        where predicate: ((T) throws -> Bool)? = nil
    ) rethrows -> T? {
        try first(where: { element in
            guard let element = element as? T else { return false }
            return try predicate?(element) ?? true
        }) as? T
    }
}

// MARK: - Bidirectional Collection Last Element of Type
extension BidirectionalCollection {
    /// Returns the last element of `Collection`that is a type `T`.
    ///
    /// In the following example, `p1` and `p2` are equivalent.
    ///
    ///     protocol P {}
    ///
    ///     struct S: P {}
    ///
    ///     let array: [any P] = [S()]
    ///
    ///     let p1: S? = array.last(where: { $0 is S }) as? S
    ///     let p2: S? = array.lastElement(ofType: S.self)
    ///
    public func lastElement<T>(
        ofType type: T.Type,
        where predicate: ((T) throws -> Bool)? = nil
    ) rethrows -> T? {
        try last(where: { element in
            guard let element = element as? T else { return false }
            return try predicate?(element) ?? true
        }) as? T
    }
}
