//
//  StringProtocol+DiacriticInsensitiveString.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

import Foundation

// MARK: - String Protocol + Diacritic Insensitive String
extension StringProtocol {
    /// Returns a diacritic-insensitive `String`.
    ///
    ///     let string: String = "À".diacriticInsensitiveString() // "A"
    ///
    public func diacriticInsensitiveString(
        locale: Locale? = nil
    ) -> String {
        folding(options: .diacriticInsensitive, locale: locale)
    }
}
