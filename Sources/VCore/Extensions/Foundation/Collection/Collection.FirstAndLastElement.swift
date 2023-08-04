//
//  Collection.FirstAndLastElement.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.11.22.
//

import Foundation

// MARK: - Collection First Element
extension Collection {
    /// Returns the first element of the sequence that is a type `T`.
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
    ///         let p1: S? = array.first { $0 is S } as? S
    ///
    ///         let p2: S? = array.firstElement(ofType: S.self)
    ///     }
    ///
    public func firstElement<T>(ofType type: T.Type) -> T? {
        first(where: { $0 is T }) as? T
    }

    /// Returns the first element of the sequence that is a type `T` and satisfies the given predicate..
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
    ///         let p1: S? = array.first { $0 is S && someCondition($0 as! S) } as? S
    ///
    ///         let p2: S? = array.firstElement(ofType: S.self, where: { someCondition($0) })
    ///     }
    ///
    public func firstElement<T>(
        ofType type: T.Type,
        where predicate: (T) -> Bool
    ) -> T? {
        first(where: { element in
            guard let element = element as? T else { return false }
            return predicate(element)
        }) as? T
    }
}

// MARK: - Bidirectional Collection Last Element
extension BidirectionalCollection {
    /// Returns the last element of the sequence that is a type `T`.
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
    ///         let p1: S? = array.last(where: { $0 is S }) as? S
    ///
    ///         let p2: S? = array.lastElement(ofType: S.self)
    ///     }
    ///
    public func lastElement<T>(ofType type: T.Type) -> T? {
        last(where: { $0 is T }) as? T
    }

    /// Returns the last element of the sequence that is a type `T` and satisfies the given predicate..
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
    ///         let p1: S? = array.last { $0 is S && someCondition($0 as! S) } as? S
    ///
    ///         let p2: S? = array.lastElement(ofType: S.self, where: { someCondition($0) })
    ///     }
    ///
    public func lastElement<T>(
        ofType type: T.Type,
        where predicate: (T) -> Bool
    ) -> T? {
        last(where: { element in
            guard let element = element as? T else { return false }
            return predicate(element)
        }) as? T
    }
}
