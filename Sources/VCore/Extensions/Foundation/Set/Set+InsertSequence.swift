//
//  Set+InsertSequence.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 18.12.23.
//

import Foundation

// MARK: - Set + Insert Sequence
extension Set {
    /// Inserts the given `Sequence` in the `Set` if they are not already present.
    ///
    ///     var set: Set<Int> = [1, 2]
    ///     set.insert(contentsOf: [3, 4]) // [1, 2, 3, 4]
    ///
    mutating public func insert(
        contentsOf newElements: some Sequence<Element>
    ) {
        newElements.forEach { insert($0) }
    }
}
