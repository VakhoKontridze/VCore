//
//  UIApplication.AppInfo.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

import UIKit

// MARK: - App Info
extension UIApplication {
    /// App display name.
    ///
    /// Usage Example:
    ///
    ///     let displayName: String? = UIApplication.shared.displayName
    ///
    public var displayName: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    /// App version.
    ///
    /// Usage Example:
    ///
    ///     let version: String? = UIApplication.shared.version
    ///
    public var version: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    /// App build number.
    ///
    /// Usage Example:
    ///
    ///     let buildNumber: String? = UIApplication.shared.buildNumber
    ///
    public var buildNumber: String? {
        Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    
    /// App bundle ID.
    ///
    /// Usage Example:
    ///
    ///     let bundleID: String? = UIApplication.shared.bundleID
    ///
    public var bundleID: String? {
        Bundle.main.bundleIdentifier
    }
}
