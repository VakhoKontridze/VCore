//
//  StringProtocol+ContainsOnlyCharacterSet.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation

extension StringProtocol {
    /// Returns `Bool` indicating if `String` only contains given `CharacterSet`.
    ///
    ///     let phoneNumber: String = "0123456789"
    ///     let flag: Bool = phoneNumber.contains(only: .decimalDigits) // true
    ///
    public func contains(only characterSet: CharacterSet) -> Bool {
        !contains { char in
            char.unicodeScalars.allSatisfy { unicodeScalar in
                !characterSet.contains(unicodeScalar)
            }
        }
    }
}

extension StringProtocol {
    /// Returns `Bool` indicating if `String` only contains given `CharacterSet`.
    ///
    ///     let phoneNumber: String = "+0123456789"
    ///     let flag: Bool = phoneNumber.contains(only: [.decimalDigits, .symbols]) // true
    ///
    public func contains(only characterSets: [CharacterSet]) -> Bool {
        contains(only: characterSets.unified)
    }
}
