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
    public func toggling(
        _ element: Element
    ) -> Self {
        var set = self
        set.toggle(element)
        return set
    }
    
    /// Removes element from a set if it's present, and inserts if not.
    ///
    ///     var nums: Set<Int> = [1, 3, 5]
    ///     nums.toggle(1) // [3, 5]
    ///     nums.toggle(1) // [1, 3, 5]
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
