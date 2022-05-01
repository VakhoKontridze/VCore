//
//  String.KeepingOnlyChars.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.22.
//

import Foundation

// MARK: - String Keeping Only Chars
extension String {
    /// Filters out characters that don't match the criteria.
    ///
    /// Usage Example:
    ///
    ///     var phoneNumber = "+0123456789"
    ///     phoneNumber.keep(only: .decimalDigits)
    ///
    mutating public func keep(only characterSet: CharacterSet) {
        self = self.keeping(only: characterSet)
    }
    
    /// Returns string with chracters, that don't match the criteria, filtered out.
    ///
    /// Usage Example:
    ///
    ///     let phoneNumber = "+0123456789"
    ///     let phoneNumberStr: String = phoneNumber.keeping(only: .decimalDigits)
    ///
    public func keeping(only characterSet: CharacterSet) -> String {
        filter { char in
            guard let unicodeScalar = char.unicodeScalars.first else { return false }
            return characterSet.contains(unicodeScalar)
        }
    }
}
