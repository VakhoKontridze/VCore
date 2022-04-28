//
//  Sequence.KeyPathSort.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

import Foundation

// MARK: - KeyPath Sort
extension Sequence {
    /// Returns the elements of a sequence, sorted using the given keypath as the comparison between elements.
    ///
    /// Usage Example:
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
    public func sorted<T: Comparable>(
        by keypath: KeyPath<Element, T>
    ) -> [Element] {
        sorted { $0[keyPath: keypath] < $1[keyPath: keypath] }
    }
}

extension Array {
    /// Sorts the elements of an array using the given keypath as the comparison between elements.
    ///
    /// Usage Example:
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
    public mutating func sort<T: Comparable>(
        by keypath: KeyPath<Element, T>
    ) {
        sort { $0[keyPath: keypath] < $1[keyPath: keypath] }
    }
}
