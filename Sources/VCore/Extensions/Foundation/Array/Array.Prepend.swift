//
//  Array.Prepend.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.07.23.
//

import Foundation

// MARK: - Array Prepend
extension Array {
    /// Adds a new element at the beginning of the `Array`.
    ///
    ///     var numbers: [Int] = [2, 3]
    ///     let index: Int = numbers.prepend(1)
    ///     // [1, 2, 3]
    ///
    public mutating func prepend(_ newElement: Element) {
        insert(newElement, at: 0)
    }

    /// Adds the elements of a sequence to the beginning of the `Array`.
    ///
    ///     var numbers: [Int] = [3, 4]
    ///     let index: Int = numbers.prepend(contentsOf: [1, 2])
    ///     // [1, 2, 3, 4]
    ///
    public mutating func prepend<S>(
        contentsOf newElements: S
    )
        where
            Element == S.Element,
            S: Collection
    {
        insert(contentsOf: newElements, at: 0)
    }
}
