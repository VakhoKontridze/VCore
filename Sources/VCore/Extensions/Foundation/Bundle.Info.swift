//
//  Bundle.Info.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

import Foundation

// MARK: - Bundle Info
extension Bundle {
    /// App display name.
    ///
    ///     let displayName: String? = Bundle.main.displayName
    ///
    public var displayName: String? {
        object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    /// App version.
    ///
    ///     let version: String? = Bundle.main.version
    ///
    public var version: String? {
        object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    /// App build number.
    ///
    ///     let buildNumber: String? = Bundle.main.buildNumber
    ///
    public var buildNumber: String? {
        object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
}
