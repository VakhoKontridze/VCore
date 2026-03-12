//
//  Collection+AllSatisfyPaired.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.02.23.
//

import Foundation

extension Collection {
    /// Returns `Bool` indicating whether every element of a sequence satisfies a given comparison predicate.
    ///
    /// This method is different from `allSatisfy(_:)`, since it passes two elements in a predicate.
    ///
    ///     let array: [Int] = [1, 2, 3]
    ///
    ///     array.allSatisfy { abs($0 - $1) <= 1 } // false
    ///     array.allSatisfy { abs($0 - $1) <= 2 } // true
    ///
    public func allSatisfy(
        _ predicate: (Element, Element) throws -> Bool
    ) rethrows -> Bool {
        let indices: [Index] = indices.map { $0 }

        for i in 0..<indices.count {
            for j in (i+1)..<indices.count {
                if try !predicate(self[indices[i]], self[indices[j]]) {
                    return false
                }
            }
        }

        return true
    }
}
