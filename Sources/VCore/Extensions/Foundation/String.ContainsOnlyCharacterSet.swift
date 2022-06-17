//
//  String.ContainsOnlyCharacterSet.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation

// MARK: - String Contains Only Character Set
extension String {
    /// Returns bool indicating if string contains only given chracters.
    ///
    ///     let phoneNumber: String = "0123456789"
    ///     let phoneNumber2: Bool = phoneNumber.contains(only: .decimalDigits) // true
    ///
    public func contains(only characterSet: CharacterSet) -> Bool {
        !contains(where: { char in
            guard let unicodeScalar = char.unicodeScalars.first else { return false }
            return !characterSet.contains(unicodeScalar)
        })
    }
}
//
// MARK: - String Contains Only Character Sets
extension String {
    /// Returns bool indicating if string contains only given chracters.
    ///
    ///     let phoneNumber: String = "+0123456789"
    ///     let phoneNumber2: Bool = phoneNumber.contains(only: [.decimalDigits, .symbols]) // true
    ///
    public func contains(only characterSets: [CharacterSet]) -> Bool {
        self.contains(only: characterSets.unified)
    }
}
