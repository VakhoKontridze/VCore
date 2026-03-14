//
//  Sequence+MinAndMaxByKeyPath.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.10.23.
//

import Foundation

nonisolated extension Sequence {
    /// Returns the minimum element in the `Sequence`, using the given `KeyPath` as the comparison between elements.
    ///
    ///     struct Item {
    ///         let value: Int
    ///     }
    ///
    ///     let items: [Item] = ...
    ///
    ///     let max: Item? = items.min(by: \.value)
    ///
    public func min(
        by keyPath: KeyPath<Element, some Comparable>
    ) -> Element? {
        self.min { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }

    /// Returns the maximum element in the `Sequence`, using the given `KeyPath` as the comparison between elements.
    ///
    ///     struct Item {
    ///         let value: Int
    ///     }
    ///
    ///     let items: [Item] = ...
    ///
    ///     let min: Item? = items.max(by: \.value)
    ///
    public func max(
        by keyPath: KeyPath<Element, some Comparable>
    ) -> Element? {
        self.max { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}
