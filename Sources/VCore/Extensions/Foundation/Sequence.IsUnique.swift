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
    ///     let nums: [Int] = [1, 3, 5]
    ///     let isUnique: Bool = nums.isUnique // true
    ///
    public var isUnique: Bool {
        var encountered: Set<Element> = []
        return allSatisfy { encountered.insert($0).inserted }
    }
    
    /// Indicates if sequence contains duplicate elements.
    ///
    ///     let nums: [Int] = [1, 1, 3, 5, 5]
    ///     let containsDuplicates: Bool = nums.containsDuplicates // true
    ///
    public var containsDuplicates: Bool {
        var encountered: Set<Element> = []
        
        for element in self {
            if encountered.contains(element) {
                return true
            } else {
                encountered.insert(element)
            }
        }
        
        return false
    }
}
