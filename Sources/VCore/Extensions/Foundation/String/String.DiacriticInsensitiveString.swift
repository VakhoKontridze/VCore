//
//  String.DiacriticInsensitiveString.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

import Foundation

// MARK: - String Diacritic Insensitive String
extension String {
    /// Returns a diacritic-insensitive `String`.
    ///
    ///     let string: String = "À".diacriticInsensitiveString() // "A"
    ///
    public func diacriticInsensitiveString(locale: Locale? = nil) -> String {
        folding(options: .diacriticInsensitive, locale: locale)
    }
}
