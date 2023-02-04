//
//  Locale.DisplayName.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.02.23.
//

import Foundation

// MARK: - Locale Display Name
extension Locale {
    /// Returns the display name for the given locale component value.
    ///
    ///     Locale(identifier: "es").displayName(forKey: .identifier) // In English locale, returns "Spanish"
    ///
    public func displayName(forKey key: NSLocale.Key) -> String? {
        guard
            let currentLocaleID: String = (UserDefaults.standard.value(forKey: "AppleLanguages") as? [String])?.first
        else {
            return nil
        }
        
        return NSLocale(localeIdentifier: currentLocaleID)
            .displayName(forKey: key, value: identifier)
    }
}
