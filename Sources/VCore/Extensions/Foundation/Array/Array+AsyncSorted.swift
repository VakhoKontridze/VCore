//
//  Array+AsyncSorted.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

import Foundation

// MARK: - Array + Async Sorted
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
        try await result.quickSort(by: areInIncreasingOrder, 0, count-1)
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
    mutating public func asyncSort(
        by areInIncreasingOrder: (Element, Element) async throws -> Bool
    ) async rethrows {
        guard !isEmpty else { return }

        try await quickSort(by: areInIncreasingOrder, 0, count-1)
    }

    private mutating func quickSort(
        by areInIncreasingOrder: (Element, Element) async throws -> Bool,
        _ low: Int,
        _ high: Int
    ) async rethrows {
        guard low < high else { return }

        let pivotIndex: Int = try await partition(by: areInIncreasingOrder, low, high)
        try await quickSort(by: areInIncreasingOrder, low, pivotIndex-1)
        try await quickSort(by: areInIncreasingOrder, pivotIndex+1, high)
    }

    private mutating func partition(
        by areInIncreasingOrder: (Element, Element) async throws -> Bool,
        _ low: Int,
        _ high: Int
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
