//
//  ArrayAsyncSorted.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

import Foundation

// MARK: - Array Async Sorted
extension Array {
    /// Returns the elements of a sequence, sorted asynchronously.
    ///
    ///     let cities: [String] = ["London", "Paris", "New York"]
    ///
    ///     let sortedCities: [String] = await cities.asyncSorted(by: { (lhs, rhs) in
    ///         try? await Task.sleep(nanoseconds: 1_000)
    ///         return lhs < rhs
    ///     })
    ///
    public func asyncSorted(
        by areInIncreasingOrder: (Element, Element) async throws -> Bool
    ) async rethrows -> [Element] {
        guard !isEmpty else { return self }

        var result = self
        try await result.quickSort(low: 0, high: count-1, by: areInIncreasingOrder)
        return result
    }

    /// Sorts the elements of an `Array` asynchronously.
    ///
    ///     var cities: [String] = ["London", "Paris", "New York"]
    ///
    ///     await cities.asyncSort(by: { (lhs, rhs) in
    ///         try? await Task.sleep(nanoseconds: 1_000)
    ///         return lhs < rhs
    ///     })
    ///
    public mutating func asyncSort(
        by areInIncreasingOrder: (Element, Element) async throws -> Bool
    ) async rethrows {
        guard !isEmpty else { return }

        try await quickSort(low: 0, high: count-1, by: areInIncreasingOrder)
    }

    private mutating func quickSort(
        low: Int,
        high: Int,
        by areInIncreasingOrder: (Element, Element) async throws -> Bool
    ) async rethrows {
        guard low < high else { return }

        let pivotIndex: Int = try await partition(low: low, high: high, by: areInIncreasingOrder)
        try await quickSort(low: low, high: pivotIndex-1, by: areInIncreasingOrder)
        try await quickSort(low: pivotIndex+1, high: high, by: areInIncreasingOrder)
    }

    private mutating func partition(
        low: Int,
        high: Int,
        by areInIncreasingOrder: (Element, Element) async throws -> Bool
    ) async rethrows -> Int {
        let pivot: Element = self[high]
        var i: Int = low-1

        for j in low..<high {
            if try await areInIncreasingOrder(self[j], pivot) {
                i += 1
                swapAt(i, j)
            }
        }

        swapAt(i+1, high)
        return i+1
    }
}
