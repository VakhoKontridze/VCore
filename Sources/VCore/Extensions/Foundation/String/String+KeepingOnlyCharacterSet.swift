//
//  String+KeepingOnlyCharacterSet.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.22.
//

import Foundation

extension String {
    /// Returns `String` with `CharacterSet`, that don't match the criteria, filtered out.
    ///
    ///     let phoneNumber: String = "+0123456789"
    ///     let phoneNumber2: String = phoneNumber.keeping(only: .decimalDigits) // "0123456789"
    ///
    public func keeping(only characterSet: CharacterSet) -> String {
        filter { char in
            char.unicodeScalars.allSatisfy { unicodeScalar in
                characterSet.contains(unicodeScalar)
            }
        }
    }
    
    /// Filters out `CharacterSet` that don't match the criteria.
    ///
    ///     var phoneNumber: String = "+0123456789"
    ///     phoneNumber.keep(only: .decimalDigits) // "0123456789"
    ///
    mutating public func keep(only characterSet: CharacterSet) {
        self = keeping(only: characterSet)
    }
}

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
        self = keeping(only: characterSets)
    }
}
