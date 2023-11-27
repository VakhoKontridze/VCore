//
//  LocalizationTableReplacingBundle.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.02.23.
//

import Foundation

// MARK: - Localization Strings File Overriding Bundle
final class LocalizationStringsFileOverridingBundle: Bundle {
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
            let path: String = LocalizationStringsFileOverridingBundle.tablePaths[bundleIdentifier],
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
            let path: String = LocalizationManager.findStringsFileBundle(bundle: bundle, locale: locale)
        else {
            return
        }
        
        _ = object_setClass(bundle, Self.self)
        tablePaths[bundleIdentifier] = path
    }
}
