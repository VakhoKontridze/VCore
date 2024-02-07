//
//  Array.Appending.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11.11.23.
//

import Foundation

// MARK: - Array Appending Element
extension Array {
    /// Returns `Array` with new element appended at the end.
    ///
    ///     [1, 2].appending(3) // [1, 2, 3]
    ///
    public func appending(_ newElement: Element) -> Self {
        self + CollectionOfOne(newElement)
    }
}

// MARK: - Array Appending Elements
extension Array {
    /// Returns `Array` with new elements of a `Sequence` appended at the end.
    ///
    ///     [1, 2].appending(contentsOf: [3, 4]) // [1, 2, 3, 4]
    ///
    public func appending<S>(
        contentsOf newElements: S
    ) -> Self
        where
            S: Sequence,
            Element == S.Element
    {
        self + newElements
    }
}
