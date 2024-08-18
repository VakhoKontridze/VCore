//
//  Array+RemoveIfPresent.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.11.23.
//

import Foundation

// MARK: - Array + Remove If Present
extension Array where Element: Equatable {
    /// Removes the element if it is present.
    ///
    ///     var array: [Int] = [1, 2, 3]
    ///     array.removeIfPresent(3) // [1, 2]
    ///
    mutating public func removeIfPresent(_ element: Element) {
        removeAll(where: { $0 == element })
    }

    /// Removes all the elements if they are present.
    ///
    ///     var array: [Int] = [1, 2, 3]
    ///     array.removeIfPresent(contentsOf: [2, 3]) // [1]
    ///
    mutating public func removeIfPresent<S>(
        contentsOf elements: S
    )
        where
            S: Sequence,
            S.Element == Element
    {
        removeAll(where: { elements.contains($0) })
    }
}
