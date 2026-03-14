//
//  StringProtocol+ContainsCharacterSet.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation

nonisolated extension StringProtocol {
    /// Returns `Bool` indicating if `String` contains a `Character` from given `CharacterSet`.
    ///
    ///     let phoneNumber: String = "0123456789"
    ///     let flag: Bool = phoneNumber.contains(.decimalDigits) // true
    ///
    public func contains(_ characterSet: CharacterSet) -> Bool {
        contains { char in
            char.unicodeScalars.allSatisfy { unicodeScalar in
                characterSet.contains(unicodeScalar)
            }
        }
    }
}

nonisolated extension StringProtocol {
    /// Returns `Bool` indicating if `String` contains a `Character` from any given `CharacterSet`s.
    ///
    ///     let phoneNumber: String = "+0123456789"
    ///     let flag: Bool = phoneNumber.contains(any: [.decimalDigits, .symbols]) // true
    ///
    public func contains(any characterSets: [CharacterSet]) -> Bool {
        contains(characterSets.unified)
    }
    
    /// Returns `Bool` indicating if `String` contains a `Character` from all given `CharacterSet`s.
    ///
    ///     let phoneNumber: String = "+0123456789"
    ///     let flag: Bool = phoneNumber.contains(all: [.decimalDigits, .symbols]) // true
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
