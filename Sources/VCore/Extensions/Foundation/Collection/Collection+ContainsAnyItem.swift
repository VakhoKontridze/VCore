//
//  Collection+ContainsAnyItem.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.23.
//

import Foundation

// MARK: - Collection + Contains Any Item
extension Collection where Element: Hashable {
    /// Returns a `Bool` indicating whether `Collection` contains any element from other `Collection`.
    ///
    ///     let collection: [Int] = [1, 2, 3]
    ///     let otherCollection: [Int] = [3, 4, 5]
    ///     collection.containsAnyItem(fromCollection: otherCollection) // true
    ///
    public func containsAnyItem<C>(
        fromCollection other: C
    ) -> Bool
        where
            C: Collection,
            Element == C.Element
    {
        guard !other.isEmpty else {
            return true
        }

        for element in other {
            if contains(element) {
                return true
            }
        }

        return false
    }
}
