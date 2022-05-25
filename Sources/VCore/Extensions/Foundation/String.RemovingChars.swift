//
//  String.RemovingChars.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.22.
//

import Foundation

// MARK: - String Removing Chars
extension String {
    /// Returns string with chracters, that don't match the criteria, filtered out.
    ///
    ///     let phoneNumber: String = "+0123456789"
    ///     let phoneNumber2: String = phoneNumber.removing(.symbols) // "0123456789"
    ///
    public func removing(_ characterSet: CharacterSet) -> String {
        filter { char in
            guard let unicodeScalar = char.unicodeScalars.first else { return false }
            return !characterSet.contains(unicodeScalar)
        }
    }
    
    /// Filters out characters that don't match the criteria.
    ///
    ///     var phoneNumber: String = "+0123456789"
    ///     phoneNumber.keep(only: .decimalDigits) // "0123456789"
    ///
    mutating public func remove(_ characterSet: CharacterSet) {
        self = self.removing(characterSet)
    }
}
