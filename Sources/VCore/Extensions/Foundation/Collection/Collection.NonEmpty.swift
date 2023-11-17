//
//  Collection.NonEmpty.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.11.23.
//

import Foundation

// MARK: - Collection Non Empty
extension Collection {
    /// Returns non-empty `Collection`, or `nil`.
    ///
    ///     let array1: [Int]? = [].nonEmpty // nil
    ///     let array2: [Int]? = [1, 2, 3].nonEmpty // [1, 2, 3]
    ///
    public var nonEmpty: Self? {
        guard !isEmpty else { return nil }
        return self
    }
}
