//
//  Array.CompactMapNonEmpty.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import Foundation

// MARK: - Compact Map Non Empty
extension Array where Element == String {
    /// Returns a string array containing non-nil, non-empty values, given transformation with each non-empty element of this sequence.
    ///
    ///     let array: [String] = ["", "Lorem Ipsum"]
    ///     let nonEmptyArray: [String] = array.compactMapNonEmpty { $0 } // ["Lorem Ipsum"]
    ///
    public func compactMapNonEmpty(_ transform: (String) throws -> String?) rethrows -> [String] {
        try compactMap { element in
            guard
                !element.isEmpty,
                let transformedElement: String = try transform(element),
                !transformedElement.isEmpty
            else {
                return nil
            }
            
            return transformedElement
        }
    }
}

extension Array where Element == Optional<String> {
    /// Returns a string array containing non-nil, non-empty values, given transformation with each non-empty element of this sequence.
    ///
    ///     let array: [String?] = [nil, "", "Lorem Ipsum"]
    ///     let nonEmptyArray: [String] = array.compactMapNonEmpty { $0 } // ["Lorem Ipsum"]
    ///
    public func compactMapNonEmpty(_ transform: (String) throws -> String?) rethrows -> [String] {
        try compactMap { element in
            guard
                let element = element,
                !element.isEmpty,
                let transformedElement: String = try transform(element),
                !transformedElement.isEmpty
            else {
                return nil
            }
            
            return transformedElement
        }
    }
}
