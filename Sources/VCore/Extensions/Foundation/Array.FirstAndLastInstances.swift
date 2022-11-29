//
//  Array.FirstAndLastInstances.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.11.22.
//

import Foundation

// MARK: - Array First and Last Instances
extension Array {
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
    ///         let p1: S? = array.first(where: { $0 is S }) as? S
    ///
    ///         let p2: S? = array.firstInstanceOfType(S.self)
    ///     }
    ///
    public func firstInstanceOfType<T>(_ type: T.Type) -> T? {
        first(where: { $0 is T }) as? T
    }
    
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
    ///         let p2: S? = array.lastInstanceOfType(S.self)
    ///     }
    ///
    public func lastInstanceOfType<T>(_ type: T.Type) -> T? {
        last(where: { $0 is T }) as? T
    }
}
