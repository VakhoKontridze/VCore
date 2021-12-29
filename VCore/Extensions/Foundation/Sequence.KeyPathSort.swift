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
    public func sorted<T: Comparable>(
        by keypath: KeyPath<Element, T>
    ) -> [Element] {
        sorted { $0[keyPath: keypath] < $1[keyPath: keypath] }
    }
}

extension Array {
    /// Sorts the elements of an array using the given keypath as the comparison between elements.
    public mutating func sort<T: Comparable>(
        by keypath: KeyPath<Element, T>
    ) {
        sort { $0[keyPath: keypath] < $1[keyPath: keypath] }
    }
}
