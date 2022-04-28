//
//  NSObject.NSObjectName.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import Foundation

// MARK: - NS Object Name
extension NSObject {
    /// `NSObject` class name.
    ///
    /// Usage Example:
    ///
    ///     let appDelegateName: String? = AppDelegate.nsObjectName // "AppDelegate"
    ///
    public static var nsObjectName: String? {
        NSStringFromClass(self)
            .components(separatedBy: ".")
            .last
    }
}
