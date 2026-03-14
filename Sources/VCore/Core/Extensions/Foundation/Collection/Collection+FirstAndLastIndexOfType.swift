//
//  Collection+FirstAndLastInstance.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

import Foundation

nonisolated extension Collection {
    /// Returns the first index of `Collection`that is a type `T`.
    ///
    /// In the following example, `p1` and `p2` are equivalent.
    ///
    ///     protocol P {}
    ///
    ///     struct S: P {}
    ///
    ///     let array: [any P] = [S()]
    ///
    ///     let index1: Int? = array.firstIndex { $0 is S }
    ///     let index2: Int? = array.firstIndex(ofType: S.self)
    ///
    public func firstIndex<T>(
        ofType type: T.Type,
        where predicate: ((T) throws -> Bool)? = nil
    ) rethrows -> Index? {
        try firstIndex { element in
            guard let element = element as? T else { return false }
            return try predicate?(element) ?? true
        }
    }
}

nonisolated extension BidirectionalCollection {
    /// Returns the last index of `BidirectionalCollection`that is a type `T`.
    ///
    /// In the following example, `p1` and `p2` are equivalent.
    ///
    ///     protocol P {}
    ///
    ///     struct S: P {}
    ///
    ///     let array: [any P] = [S()]
    ///
    ///     let index1: Int? = array.lastIndex { $0 is S }
    ///     let index2: Int? = array.lastIndex(ofType: S.self)
    ///
    public func lastIndex<T>(
        ofType type: T.Type,
        where predicate: ((T) throws -> Bool)? = nil
    ) rethrows -> Index? {
        try lastIndex { element in
            guard let element = element as? T else { return false }
            return try predicate?(element) ?? true
        }
    }
}
