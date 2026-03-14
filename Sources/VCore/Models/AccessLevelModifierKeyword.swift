//
//  AccessLevelModifierKeyword.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.05.24.
//

import Foundation

/// Access level modifier.
public nonisolated enum AccessLevelModifierKeyword: String, Sendable, CaseIterable {
    /// Open.
    case `open` = "open"

    /// Public.
    case `public` = "public"

    /// Package.
    case `package` = "package"

    /// Internal.
    case `internal` = "internal"

    /// Fileprivate.
    case `fileprivate` = "fileprivate"

    /// Private.
    case `private` = "private"
}
