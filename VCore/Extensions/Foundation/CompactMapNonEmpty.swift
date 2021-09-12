//
//  CompactMapNonEmpty.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import Foundation

// MARK:- Compact Map Non Empty
extension Array where Element == Optional<String> {
    /// Returns a string array containing non-nil, non-empty values, given transformation with each element of this sequence
    public func compactMapNonEmpty(_ transform: (String) throws -> String?) rethrows -> [String] {
        try compactMap { element in
            guard
                let element = element,
                !element.isEmpty,
                let transformedElement = try transform(element)
            else {
                return nil
            }
            
            return transformedElement
        }
    }
}
