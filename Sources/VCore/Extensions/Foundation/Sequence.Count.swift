//
//  Sequence.Count.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.05.22.
//

import Foundation

// MARK: - Sequence Count
extension Sequence {
    /// Returns the number of element of the sequence that satisfies the given predicate.
    ///
    ///     let nums: [Int] = [3, 7, 4, -2, 9, -6, 10, 1]
    ///     let positiveCount: Int = nums.count { $0 > 0 } // 6
    ///
    public func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
        var count: Int = 0
        
        for element in self {
            if try predicate(element) {
                count += 1
            }
        }
        
        return count
    }
}
