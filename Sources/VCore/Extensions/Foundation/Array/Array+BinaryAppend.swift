//
//  Array+BinaryAppend.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

import Foundation

// MARK: - Array + Binary Append
extension Array {
    /// Insert element in appropriate place using a binary append algorithm.
    ///
    ///     var numbers: [Int] = [1, 2, 4, 5, 6]
    ///     let index: Int = numbers.binaryAppend(3, by: { $0 < $1 }) // 2
    ///     // [1, 2, 3, 4, 5, 6]
    ///
    @discardableResult
    mutating public func binaryAppend(
        _ element: Element,
        by areInIncreasingOrder: (Element, Element) throws -> Bool
    ) rethrows -> Int {
        var start: Int = 0
        var end: Int = count - 1

        while start <= end {
            let mid: Int = (start + end) / 2

            if try areInIncreasingOrder(self[mid], element) {
                start += 1
            } else {
                end -= 1
            }
        }

        insert(element, at: start)

        return start
    }
    
    /// Insert element in appropriate place using a binary append algorithm.
    ///
    ///     var objects: [SomeClass] = [...]
    ///     let index: Int = numbers.binaryAppend(newObject, by: \.value)
    ///
    @discardableResult
    mutating public func binaryAppend(
        _ element: Element,
        by keyPath: KeyPath<Element, some Comparable>
    ) -> Int {
        binaryAppend(element, by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })
    }
}
