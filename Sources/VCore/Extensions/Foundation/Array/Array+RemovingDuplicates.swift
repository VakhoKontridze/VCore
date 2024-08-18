//
//  Array+RemovingDuplicates.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation

// MARK: - Array + Removing Duplicates
extension Array where Element: Equatable {
    /// Returns a sequence with only the unique elements of this sequence, in the
    /// order of the first occurrence of each unique element.
    ///
    ///     let numbers: [Int] = [1, 1, 3, 5, 5]
    ///     let uniqueNumbers: [Int] = numbers.removingDuplicates() // [1, 3, 5]
    ///
    public func removingDuplicates() -> [Element] {
        var result: [Element] = []
        
        for element in self where !result.contains(element) {
            result.append(element)
        }
        
        return result
    }
    
    /// Removes duplicates from sequence and keep unique elements, in the
    /// order of the first occurrence of each unique element.
    ///
    ///     var numbers: [Int] = [1, 1, 3, 5, 5]
    ///     numbers.removeDuplicates() // [1, 3, 5]
    ///
    mutating public func removeDuplicates() {
        self = removingDuplicates()
    }
}
