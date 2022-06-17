//
//  String.KeepingOnlyCharacterSet.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.22.
//

import Foundation

// MARK: - String Keeping Only Character Set
extension String {
    /// Returns `String` with `CharacterSet`, that don't match the criteria, filtered out.
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
    
    /// Filters out `CharacterSet` that don't match the criteria.
    ///
    ///     var phoneNumber: String = "+0123456789"
    ///     phoneNumber.keep(only: .decimalDigits) // "0123456789"
    ///
    mutating public func keep(only characterSet: CharacterSet) {
        self = self.keeping(only: characterSet)
    }
}

// MARK: - String Keeping Only Character Sets
extension String {
    /// Returns `String` with `CharacterSet`, that don't match the criteria, filtered out.
    ///
    ///     let phoneNumber: String = "+0123456789A"
    ///     let phoneNumber2: String = phoneNumber.keeping(only: [.decimalDigits, .symbols]) // "+0123456789"
    ///
    public func keeping(only characterSets: [CharacterSet]) -> String {
        self.keeping(only: characterSets.unified)
    }
    
    /// Filters out `CharacterSet` that don't match the criteria.
    ///
    ///     var phoneNumber: String = "+0123456789A"
    ///     phoneNumber.keep(only: [.decimalDigits, .symbols]) // "+0123456789"
    ///
    mutating public func keep(only characterSets: [CharacterSet]) {
        self = self.keeping(only: characterSets)
    }
}
