//
//  Locale.IsEquivalent.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.02.23.
//

import Foundation

// MARK: - Locale Is Equivalent
extension Locale {
    /// Returns `Bool` indicated if two `Locale`s are equivalent.
    ///
    /// During comparison, `region?.identifier` and `language.script?.identifier`
    /// are also considered equal, even if it's present in one `Locale` and absent in another,
    /// as long as it's a code for `Locale.current`.
    ///
    /// For instance, "en" and "en-US" are equivalent, if `Locale.current.region?.identifier` equals "US".
    ///
    ///     let lhs: Locale = .init(identifier: "en")
    ///     let rhs: Locale = .init(identifier: "en-US")
    ///
    ///     lhs == rhs // false
    ///
    ///     lhs.isEquivalent(to: rhs) // true, if `Locale.current.region?.identifier` is "US"
    ///
    public func isEquivalent(to other: Locale) -> Bool {
        if 
            language.languageCode?.identifier != other.language.languageCode?.identifier
        {
            return false
        }

        if
            (regionIdentifierOrCurrent != nil || other.regionIdentifierOrCurrent != nil) &&
            regionIdentifierOrCurrent != other.regionIdentifierOrCurrent
        {
            return false
        }
        
        if
            (languageScriptIdentifierOrCurrent != nil || other.languageScriptIdentifierOrCurrent != nil) &&
            languageScriptIdentifierOrCurrent != other.languageScriptIdentifierOrCurrent
        {
            return false
        }
        
//        if
//            (variantIdentifierOrCurrent != nil || other.variantIdentifierOrCurrent != nil) &&
//            variantIdentifierOrCurrent != other.variantIdentifierOrCurrent
//        {
//            return false
//        }
        
        return true
    }
    
    private var regionIdentifierOrCurrent: String? { region?.identifier ?? Locale.current.region?.identifier }

    private var languageScriptIdentifierOrCurrent: String? { language.script?.identifier ?? Locale.current.language.script?.identifier }
}
