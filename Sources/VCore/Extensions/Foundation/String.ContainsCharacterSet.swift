//
//  String.ContainsCharacterSet.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation

// MARK: - String Contains Character Set
extension String {
    /// Returns `Bool` indicating if `String` contains given `CharacterSet`.
    ///
    ///     let phoneNumber: String = "0123456789"
    ///     let phoneNumber2: Bool = phoneNumber.contains(.decimalDigits) // true
    ///
    public func contains(_ characterSet: CharacterSet) -> Bool {
        contains(where: { char in
            guard let unicodeScalar = char.unicodeScalars.first else { return false }
            return characterSet.contains(unicodeScalar)
        })
    }
}

// MARK: - String Contains Character Sets
extension String {
    /// Returns `Bool` indicating if `String` contains given `CharacterSet`.
    ///
    ///     let phoneNumber: String = "+0123456789"
    ///     let phoneNumber2: Bool = phoneNumber.contains([.decimalDigits, .symbols]) // true
    ///
    public func contains(_ characterSets: [CharacterSet]) -> Bool {
        contains(characterSets.unified)
    }
}
