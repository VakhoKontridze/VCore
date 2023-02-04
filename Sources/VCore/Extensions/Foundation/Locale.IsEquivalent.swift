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
    /// During comparison, `regionCode`, `scriptCode`, and `variantCode`
    /// are also considered equal, even if it's present in one `Locale` and absent in another,
    /// as long as it's a code for `Locale.current`.
    ///
    /// For instance, "en" and "en-US" are equivalent, if `Locale.current.regionCode`
    /// equals "US".
    ///
    ///     let lhs: Locale = .init(identifier: "en")
    ///     let rhs: Locale = .init(identifier: "en-US")
    ///
    ///     lhs == rhs // false
    ///
    ///     lhs.isEquivalent(to: rhs) // true, if `Locale.current.regionCode` is "US"
    ///
    public func isEquivalent(to other: Locale) -> Bool {
        guard languageCode == other.languageCode else { return false }
        
        if
            (regionCodeOrCurrent != nil || other.regionCodeOrCurrent != nil) &&
            regionCodeOrCurrent != other.regionCodeOrCurrent
        {
            return false
        }
        
        if
            (scriptCodeOrCurrent != nil || other.scriptCodeOrCurrent != nil) &&
            scriptCodeOrCurrent != other.scriptCodeOrCurrent
        {
            return false
        }
        
        if
            (variantCodeOrCurrent != nil || other.variantCodeOrCurrent != nil) &&
            variantCodeOrCurrent != other.variantCodeOrCurrent
        {
            return false
        }
        
        return true
    }
    
    private var regionCodeOrCurrent: String? { regionCode ?? Locale.current.regionCode }
    
    private var scriptCodeOrCurrent: String? { scriptCode ?? Locale.current.scriptCode }
    
    private var variantCodeOrCurrent: String? { variantCode ?? Locale.current.variantCode }
}
