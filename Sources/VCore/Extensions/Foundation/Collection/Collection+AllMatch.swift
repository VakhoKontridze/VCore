//
//  Collection+AllMatch.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.02.23.
//

import Foundation

// MARK: - Collection + All Match
extension Collection {
    /// Returns `Bool` indicating whether every element of a sequence satisfies a given comparison predicate.
    ///
    /// This method is different from `allSatisfy(_:)`, since it passes two elements in a predicate.
    ///
    ///     let array: [Int] = [1, 2, 3]
    ///
    ///     array.allMatch { abs($0 - $1) <= 1 } // false
    ///     array.allMatch { abs($0 - $1) <= 2 } // true
    ///
    public func allMatch(
        _ predicate: (Element, Element) throws -> Bool
    ) rethrows -> Bool {
        for (i, a) in self.enumerated() {
            for (j, b) in self.enumerated() {
                guard i != j else { continue }
                
                if try !predicate(a, b) {
                    return false
                }
            }
        }
        
        return true
    }
}
