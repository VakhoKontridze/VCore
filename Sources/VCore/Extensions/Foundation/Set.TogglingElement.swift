//
//  Set.TogglingElement.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.22.
//

import Foundation

// MARK: - Set Toggling Element
extension Set {
    /// Returns set with element toggled, i.e., removed if it's present, and inserted if not.
    ///
    ///     let numbers1: Set<Int> = [1, 3, 5]
    ///     let numbers2: Set<Int> = numbers1.toggling(1) // [3, 5]
    ///     let numbers3: Set<Int> = numbers2.toggling(1) // [1, 3, 5]
    ///
    public func toggling(
        _ element: Element
    ) -> Self {
        var set = self
        set.toggle(element)
        return set
    }
    
    /// Removes element from a set if it's present, and inserts if not.
    ///
    ///     var numbers: Set<Int> = [1, 3, 5]
    ///     numbers.toggle(1) // [3, 5]
    ///     numbers.toggle(1) // [1, 3, 5]
    ///
    mutating public func toggle(
        _ element: Element
    ) {
        if contains(element) {
            remove(element)
        } else {
            insert(element)
        }
    }
}
