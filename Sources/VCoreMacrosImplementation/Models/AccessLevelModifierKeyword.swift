//
//  AccessLevelModifierKeyword.swift
//  VCoreMacrosImplementation
//
//  Created by Vakhtang Kontridze on 23.05.24.
//

import Foundation
import SwiftSyntax

// MARK: - Access Level Modifier Keyword
enum AccessLevelModifierKeyword: String, CaseIterable {
    // MARK: Cases
    case `open` = "open"
    case `public` = "public"
    case `package` = "package"
    case `internal` = "internal"
    case `fileprivate` = "fileprivate"
    case `private` = "private"

    // MARK: Properties
    var swiftSyntaxKeyword: Keyword {
        switch self {
        case .open: .open
        case .public: .public
        case .package: .package
        case .internal: .internal
        case .fileprivate: .fileprivate
        case .private: .private
        }
    }

    // MARK: Initializers
    static var `default`: Self { .internal }
}
