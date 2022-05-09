//
//  String.KeepingOnlyChars.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.22.
//

import Foundation

// MARK: - String Keeping Only Chars
extension String {
    /// Returns string with chracters, that don't match the criteria, filtered out.
    ///
    /// Usage Example:
    ///
    ///     let phoneNumber: String = "+0123456789"
    ///     let phoneNumber2: String = phoneNumber.keeping(only: .decimalDigits) // "0123456789"
    ///
    public func keeping(only characterSet: CharacterSet) -> String {
        filter { char in
            guard let unicodeScalar = char.unicodeScalars.first else { return false }
            return characterSet.contains(unicodeScalar)
        }
    }
    
    /// Filters out characters that don't match the criteria.
    ///
    /// Usage Example:
    ///
    ///     var phoneNumber: String = "+0123456789"
    ///     phoneNumber.keep(only: .decimalDigits) // "0123456789"
    ///
    mutating public func keep(only characterSet: CharacterSet) {
        self = self.keeping(only: characterSet)
    }
}
