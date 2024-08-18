//
//  Sequence+ContainsDuplicates.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.01.24.
//

import Foundation

// MARK: - Sequence + Contains Duplicates
extension Sequence where Element: Hashable {
    /// Indicates if sequence contains duplicate elements.
    ///
    ///     let numbers: [Int] = [1, 1, 3, 5, 5]
    ///     let containsDuplicates: Bool = numbers.containsDuplicates // true
    ///
    public var containsDuplicates: Bool {
        var encountered: Set<Element> = []

        for element in self {
            if encountered.contains(element) {
                return true
            } else {
                encountered.insert(element)
            }
        }

        return false
    }
}
