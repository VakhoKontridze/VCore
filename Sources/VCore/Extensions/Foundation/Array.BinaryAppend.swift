//
//  Array.BinaryAppend.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

import Foundation

// MARK: - Array Binary Append
extension Array {
    /// Insert element in appropriate place using a binary append algorithm.
    ///
    ///     var numbers: [Int] = [1, 2, 4, 5, 6]
    ///     let index: Int = numbers.binaryAppend(3, by: { $0 < $1 }) // 2
    ///     // [1, 2, 3, 4, 5, 6]
    ///
    @discardableResult public mutating func binaryAppend(
        _ item: Element,
        by areInIncreasingOrder: (Element, Element) -> Bool
    ) -> Int {
        var start: Int = 0
        var end: Int = count - 1

        while start <= end {
            let mid: Int = (start + end) / 2

            if areInIncreasingOrder(self[mid], item) {
                start += 1
            } else {
                end -= 1
            }
        }

        insert(item, at: start)

        return start
    }
}
