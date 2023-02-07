//
//  LocalizationManager.Localized.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.02.23.
//

import Foundation

// MARK: - Localization Manager Localized
extension LocalizationManager {
    /// Returns localized `String` from the given table and bundle.
    ///
    /// This methods finds correct table path within the `Bundle`, once localization has changed.
    /// For additional info, refer to `LocalizationManager`.
    public func localized(
        _ key: String,
        tableName: String? = nil,
        bundle: Bundle = .main,
        value: String = ""
    ) -> String {
        guard
            let path: String = Self.findLocalizationTableBundle(bundle: bundle, locale: currentLocale),
            let currentLocaleBundle: Bundle = .init(path: path)
        else {
            return value
        }
        
        return currentLocaleBundle.localizedString(
            forKey: key,
            value: value,
            table: tableName
        )
    }
    
    /*private*/ static func findLocalizationTableBundle(
        bundle: Bundle,
        locale: Locale
    ) -> String? {
        let fileType: String = "lproj"
        
        return
            bundle.path(forResource: locale.identifier, ofType: fileType) ??
            bundle.path(forResource: locale.languageCode, ofType: fileType)  // Just in case "en_US" is passed, but file is called "en"
    }
}

// MARK: - String Localized with Manager
extension String {
    /// Returns localized `String` from the given table and bundle.
    ///
    /// This methods finds correct table path within the `Bundle`, once localization has changed.
    /// For additional info, refer to `LocalizationManager`.
    ///
    ///     "message".localizedWithManager()
    ///
    public func localizedWithManager(
        tableName: String? = nil,
        bundle: Bundle = .main,
        value: String = ""
    ) -> String {
        LocalizationManager.shared.localized(
            self,
            tableName: tableName,
            bundle: bundle,
            value: value
        )
    }
}
