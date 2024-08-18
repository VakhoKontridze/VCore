//
//  Collection+RandomElements.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 30.04.23.
//

import Foundation

// MARK: - Collection + Random Elements
extension Collection {
    /// Returns random elements from the collection up to specified count.
    ///
    ///     let numbers: [Int] = [10, 20, 30, 40, 50, 60]
    ///     let randomNumbers: [Int?] = numbers.randomElements(3) // [10, 60, 40]
    ///
    public func randomElements(_ n: Int) -> [Element]? {
        guard 0 <= n, n <= count else { return nil }

        return indices.shuffled().prefix(upTo: n).map { self[$0] }
    }
}
