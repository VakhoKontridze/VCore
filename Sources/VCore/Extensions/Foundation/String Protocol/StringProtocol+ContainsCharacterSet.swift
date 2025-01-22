//
//  StringProtocol+ContainsCharacterSet.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation

// MARK: - String Protocol + Contains Character Set
extension StringProtocol {
    /// Returns `Bool` indicating if `String` contains a `Character` from given `CharacterSet`.
    ///
    ///     let phoneNumber: String = "0123456789"
    ///     let flag: Bool = phoneNumber.contains(.decimalDigits) // true
    ///
    public func contains(_ characterSet: CharacterSet) -> Bool {
        contains(where: { char in
            guard let unicodeScalar: Unicode.Scalar = char.unicodeScalars.first else { return false }
            return characterSet.contains(unicodeScalar)
        })
    }
}

// MARK: - String Protocol + Contains Character Sets
extension StringProtocol {
    /// Returns `Bool` indicating if `String` contains a `Character` from any given `CharacterSet`s.
    ///
    ///     let phoneNumber: String = "+0123456789"
    ///     let flag: Bool = phoneNumber.contains([.decimalDigits, .symbols]) // true
    ///
    public func contains(any characterSets: [CharacterSet]) -> Bool {
        contains(characterSets.unified)
    }
    
    /// Returns `Bool` indicating if `String` contains a `Character` from all given `CharacterSet`s.
    ///
    ///     let phoneNumber: String = "+0123456789"
    ///     let flag: Bool = phoneNumber.contains([.decimalDigits, .symbols]) // true
    ///
    public func contains(all characterSets: [CharacterSet]) -> Bool {
        for characterSet in characterSets {
            if !contains(characterSet) {
                return false
            }
        }
        
        return true
    }
}
