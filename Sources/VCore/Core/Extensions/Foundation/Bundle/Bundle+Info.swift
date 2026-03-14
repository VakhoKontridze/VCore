//
//  Bundle+Info.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

import Foundation

nonisolated extension Bundle {
    /// Name.
    ///
    ///     let name: String? = Bundle.main.name
    ///
    public var name: String? {
        object(forInfoDictionaryKey: "CFBundleName") as? String
    }

    /// Display name.
    ///
    ///     let displayName: String? = Bundle.main.displayName
    ///
    public var displayName: String? {
        object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }

    /// Version.
    ///
    ///     let version: String? = Bundle.main.version
    ///
    public var version: String? {
        object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    /// Build number.
    ///
    ///     let buildNumber: String? = Bundle.main.buildNumber
    ///
    public var buildNumber: String? {
        object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
}
