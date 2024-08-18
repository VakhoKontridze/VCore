//
//  String+RemovingCharacterSet.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.22.
//

import Foundation
import VCoreShared

// MARK: - String + Removing Character Set
extension String {
    /// Returns `String` with `CharacterSet`, that don't match the criteria, filtered out.
    ///
    ///     let phoneNumber: String = "+0123456789"
    ///     let phoneNumber2: String = phoneNumber.removing(.symbols) // "0123456789"
    ///
    public func removing(_ characterSet: CharacterSet) -> String {
        _removing(characterSet)
    }
    
    /// Filters out `CharacterSet` that don't match the criteria.
    ///
    ///     var phoneNumber: String = "+0123456789"
    ///     phoneNumber.remove(.symbols) // "0123456789"
    ///
    mutating public func remove(_ characterSet: CharacterSet) {
        self = removing(characterSet)
    }
}

// MARK: - String + Removing Character Sets
extension String {
    /// Returns `String` with `CharacterSet`, that don't match the criteria, filtered out.
    ///
    ///     let phoneNumber: String = "+0123456789A"
    ///     let phoneNumber2: String = phoneNumber.removing([.symbols, .letters]) // "0123456789"
    ///
    public func removing(_ characterSets: [CharacterSet]) -> String {
        removing(characterSets.unified)
    }
    
    /// Filters out `CharacterSet` that don't match the criteria.
    ///
    ///     var phoneNumber: String = "+0123456789A"
    ///     phoneNumber.remove([.symbols, .letters]) // "0123456789"
    ///
    mutating public func remove(_ characterSets: [CharacterSet]) {
        self = removing(characterSets)
    }
}
