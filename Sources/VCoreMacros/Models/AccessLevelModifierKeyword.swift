//
//  AccessLevelModifierKeyword.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 23.05.24.
//

import Foundation

// MARK: - Access Level Modifier Keyword
/// Enumeration that represent access level modifier.
public enum AccessLevelModifierKeyword: String {
    case `open` = "open"
    case `public` = "public"
    case `package` = "package"
    case `internal` = "internal"
    case `fileprivate` = "fileprivate"
    case `private` = "private"
}
