//
//  Collection.FirstAndLastInstance.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

import Foundation

// MARK: - Collection First Index
extension Collection {
    /// Returns the first index of the sequence that is a type `T`.
    ///
    /// In the following example, `p1` and `p2` are equivalent.
    ///
    ///     protocol P {}
    ///
    ///     struct S: P {}
    ///
    ///     func a() {
    ///         let array: [any P] = [S()]
    ///
    ///         let index1: Int? = array.firstIndex { $0 is S }
    ///
    ///         let index2: Int? = array.firstIndex(ofType: S.self)
    ///     }
    ///
    public func firstIndex<T>(ofType type: T.Type) -> Index? {
        firstIndex(where: { $0 is T })
    }

    /// Returns the first index of the sequence that is a type `T` and satisfies the given predicate..
    ///
    /// In the following example, `p1` and `p2` are equivalent.
    ///
    ///     protocol P {}
    ///
    ///     struct S: P {}
    ///
    ///     func a() {
    ///         let array: [any P] = [S()]
    ///
    ///         let index1: Int? = array.firstIndex { $0 is S && someCondition($0 as! S) }
    ///
    ///         let index2: Int? = array.firstIndex(ofType: S.self, where: { someCondition($0) })
    ///     }
    ///
    public func firstIndex<T>(
        ofType type: T.Type,
        where predicate: (T) -> Bool
    ) -> Index? {
        firstIndex(where: { element in
            guard let element = element as? T else { return false }
            return predicate(element)
        })
    }
}

// MARK: - Bidirectional Collection Last Index
extension BidirectionalCollection {
    /// Returns the last index of the sequence that is a type `T`.
    ///
    /// In the following example, `p1` and `p2` are equivalent.
    ///
    ///     protocol P {}
    ///
    ///     struct S: P {}
    ///
    ///     func a() {
    ///         let array: [any P] = [S()]
    ///
    ///         let index1: Int? = array.lastIndex { $0 is S }
    ///
    ///         let index2: Int? = array.lastIndex(ofType: S.self)
    ///     }
    ///
    public func lastIndex<T>(ofType type: T.Type) -> Index? {
        lastIndex(where: { $0 is T })
    }

    /// Returns the last index of the sequence that is a type `T` and satisfies the given predicate..
    ///
    /// In the following example, `p1` and `p2` are equivalent.
    ///
    ///     protocol P {}
    ///
    ///     struct S: P {}
    ///
    ///     func a() {
    ///         let array: [any P] = [S()]
    ///
    ///         let index1: Int? = array.lastIndex { $0 is S && someCondition($0 as! S) }
    ///
    ///         let index2: Int? = array.lastIndex(ofType: S.self, where: { someCondition($0) })
    ///     }
    ///
    public func lastIndex<T>(
        ofType type: T.Type,
        where predicate: (T) -> Bool
    ) -> Index? {
        lastIndex(where: { element in
            guard let element = element as? T else { return false }
            return predicate(element)
        })
    }
}
