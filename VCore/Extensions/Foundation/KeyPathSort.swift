//
//  KeyPathSort.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

import Foundation

// MARK: - KeyPath Sort
extension Sequence {
    /// Sorts sequence by a key path.
    public func sorted<T: Comparable>(
        by keypath: KeyPath<Element, T>
    ) -> [Element] {
        sorted { $0[keyPath: keypath] < $1[keyPath: keypath] }
    }
}
