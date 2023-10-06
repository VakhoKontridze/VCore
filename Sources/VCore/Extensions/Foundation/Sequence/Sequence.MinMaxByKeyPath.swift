//
//  Sequence.MinMaxByKeyPath.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.10.23.
//

import Foundation

// MARK: - Sequence Min Max by KeyPath
extension Sequence {
    /// Returns the minimum element in the `Sequence`, using the given `KeyPath` as the comparison between elements.
    ///
    ///     struct SomeObject {
    ///         let value: Int
    ///     }
    ///
    ///     let objects: [SomeObject] = ...
    ///
    ///     let max: Object? = objects.min(by: \.value)
    ///
    public func min(
        by keyPath: KeyPath<Element, some Comparable>
    ) -> Element? {
        self.min { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }

    /// Returns the maximum element in the `Sequence`, using the given `KeyPath` as the comparison between elements.
    ///
    ///     struct SomeObject {
    ///         let value: Int
    ///     }
    ///
    ///     let objects: [SomeObject] = ...
    ///
    ///     let max: Object? = objects.max(by: \.value)
    ///
    public func max(
        by keyPath: KeyPath<Element, some Comparable>
    ) -> Element? {
        self.max { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}
