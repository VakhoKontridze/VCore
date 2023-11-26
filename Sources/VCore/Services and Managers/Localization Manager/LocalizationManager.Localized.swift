//
//  LocalizationManager.Localized.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.02.23.
//

import Foundation

// MARK: - Localization Manager Localized in Strings File
extension LocalizationManager {
    /// Returns localized `String` from the given table and bundle.
    ///
    /// This methods finds correct table path within the `Bundle`, once localization has changed.
    /// For additional info, refer to `LocalizationManager`.
    public func localizedInStringsFile(
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

// MARK: - Localization Manager Localized in String Catalog
extension LocalizationManager {
    /// Returns localized `String` from the given table and bundle.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    public func localizedInStringCatalog(
        _ key: String,
        table: String? = nil,
        bundle: Bundle? = nil,
        locale: Locale = .current,
        comment: StaticString? = nil
    ) -> String {
        .init(
            localized: String.LocalizationValue(key),
            table: table,
            bundle: bundle,
            locale: locale,
            comment: comment
        )
    }
}
