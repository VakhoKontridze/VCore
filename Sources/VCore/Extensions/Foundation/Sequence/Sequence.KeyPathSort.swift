//
//  Sequence.KeyPathSort.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

import Foundation

// MARK: - KeyPath Sort
extension Sequence {
    /// Returns the elements of a sequence, sorted using the given `KeyPath` as the comparison between elements.
    ///
    ///     struct City {
    ///         let name: String
    ///     }
    ///
    ///     let cities: [City] = [
    ///         .init(name: "London"),
    ///         .init(name: "Paris"),
    ///         .init(name: "New York")
    ///     ]
    ///
    ///     let sortedCities: [City] = cities.sorted(by: \.name)
    ///     // [City(name: "London"), City(name: "New York"), City(name: "Paris")]
    ///
    public func sorted(by keyPath: KeyPath<Element, some Comparable>) -> [Element] {
        sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}

extension Array {
    /// Sorts the elements of an `Array` using the given `KeyPath` as the comparison between elements.
    ///
    ///     var cities: [City] = [
    ///         .init(name: "London"),
    ///         .init(name: "Paris"),
    ///         .init(name: "New York")
    ///     ]
    ///
    ///     cities.sort(by: \.name)
    ///     // [City(name: "London"), City(name: "New York"), City(name: "Paris")]
    ///
    mutating public func sort(by keyPath: KeyPath<Element, some Comparable> ) {
        sort { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}
