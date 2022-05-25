//
//  Set.Toggle.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.22.
//

import Foundation

// MARK: - Toggle Set Element
extension Set {
    /// Inserts element in a set if it's not present, and if present, removes it.
    ///
    ///     var nums: Set<Int> = [1, 3, 5]
    ///     nums.toggle(1) // [3, 5]
    ///     nums.toggle(1) // [1, 3, 5]
    ///
    mutating public func toggle(
        _ element: Element
    ) {
        switch contains(element) {
        case false: insert(element)
        case true: remove(element)
        }
    }
}
