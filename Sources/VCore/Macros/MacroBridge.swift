//
//  MacroBridge.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.05.24.
//

import Foundation

// MARK: - Access Level Modifier Keyword
/// Enumeration that represent access level modifier.
public enum AccessLevelModifierKeyword: String {
    /// Open.
    case `open` = "open"

    /// Public.
    case `public` = "public"

    /// Package.
    case `package` = "package"

    /// Internal.
    case `internal` = "internal"

    /// Fileprivate/
    case `fileprivate` = "fileprivate"

    /// Private.
    case `private` = "private"
}
