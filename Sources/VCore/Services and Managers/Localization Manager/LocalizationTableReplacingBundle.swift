//
//  LocalizationTableReplacingBundle.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.02.23.
//

import Foundation

// MARK: - Localization Replacing Bundle
final class LocalizationTableReplacingBundle: Bundle {
    // MARK: Properties
    static var localizationTablePaths: [String: String] = [:]
    
    // MARK: Methods
    override func localizedString(
        forKey key: String,
        value: String?,
        table tableName: String?
    ) -> String {
        guard
            let bundleIdentifier,
            let path: String = LocalizationTableReplacingBundle.localizationTablePaths[bundleIdentifier],
            let bundle: Bundle = .init(path: path)
        else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}
