//
//  LocalizationTableReplacingBundle.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.02.23.
//

import Foundation

// MARK: - Localization Table Overriding Bundle
final class LocalizationTableOverridingBundle: Bundle {
    // MARK: Properties
    static var tablePaths: [String: String] = [:]
    
    // MARK: Methods
    override func localizedString(
        forKey key: String,
        value: String?,
        table tableName: String?
    ) -> String {
        guard
            let bundleIdentifier,
            let path: String = LocalizationTableOverridingBundle.tablePaths[bundleIdentifier],
            let bundle: Bundle = .init(path: path)
        else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
    
    // MARK: Replacement
    static func overrideTable(
        toLocale locale: Locale,
        inBundle bundle: Bundle
    ) {
        guard
            let bundleIdentifier: String = bundle.bundleIdentifier,
            let path: String =
                bundle.path(forResource: locale.identifier, ofType: "lproj") ??
                bundle.path(forResource: locale.languageCode, ofType: "lproj") // Just in case "en_US" is passed, but file is called "en"
        else {
            return
        }

        _ = object_setClass(bundle, Self.self)
        tablePaths[bundleIdentifier] = path
    }
}
