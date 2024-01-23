//
//  Sequence.IsUnique.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation

// MARK: - Sequence Is Unique
extension Sequence where Element: Hashable {
    /// Indicates if sequence doesn't contain duplicate elements.
    ///
    ///     let numbers: [Int] = [1, 3, 5]
    ///     let isUnique: Bool = numbers.isUnique // true
    ///
    public var isUnique: Bool {
        var encountered: Set<Element> = []
        return allSatisfy { encountered.insert($0).inserted }
    }
}
