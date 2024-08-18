//
//  Array+Prepending.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.07.23.
//

import Foundation

// MARK: - Array + Prepending Element
extension Array {
    /// Returns `Array` with new element prepended at the beginning.
    ///
    ///     [2, 3].prepending(1) // [1, 2, 3]
    ///
    public func prepending(_ newElement: Element) -> Self {
        CollectionOfOne(newElement) + self
    }

    /// Adds a new element at the beginning of the `Array`.
    ///
    ///     var numbers: [Int] = [2, 3]
    ///     let index: Int = numbers.prepend(1)
    ///     // [1, 2, 3]
    ///
    mutating public func prepend(_ newElement: Element) {
        insert(newElement, at: 0)
    }
}

// MARK: - Array + Prepending Elements
extension Array {
    /// Returns `Array` with new elements of a `Sequence` prepended at the beginning.
    ///
    ///     [3, 4].prepending(contentsOf: [1, 2]) // [1, 2, 3, 4]
    ///
    public func prepending<S>(
        contentsOf newElements: S
    ) -> Self
        where
            S: Sequence,
            Element == S.Element
    {
        newElements + self
    }

    /// Adds the elements of a `Sequence` to the beginning of the `Array`.
    ///
    ///     var numbers: [Int] = [3, 4]
    ///     let index: Int = numbers.prepend(contentsOf: [1, 2])
    ///     // [1, 2, 3, 4]
    ///
    mutating public func prepend<S>(
        contentsOf newElements: S
    )
        where
            Element == S.Element,
            S: Collection
    {
        insert(contentsOf: newElements, at: 0)
    }
}
