//
//  Collection.FirstIndexAndElement.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.22.
//

import Foundation

// MARK: - Collection First Index and Element
extension Collection {
    /// Returns first index and element of `Collection` that satisfies the given predicate.
    ///
    /// Used for avoiding accessing both index and element with built-in methods.
    ///
    ///     let nums: [Int] = [1, 3, 5]
    ///     guard let (index, num): (Int, Int) = nums.firstIndexAndElement(where: { $0 * $0 >= 10 }) else { return }
    ///
    public func firstIndexAndElement(
        where predicate: (Element) throws -> Bool
    ) rethrows -> (index: Index, element: Element)? {
        guard let index: Index = try firstIndex(where: predicate) else { return nil }
        let element: Element = self[index]
        
        return (index, element)
    }
}
