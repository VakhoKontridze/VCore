//
//  DeclGroupSyntax.AccessLevelModifier.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

// Duplicated to VCoreMacros

import Foundation
import SwiftSyntax

// MARK: - Decl Group Syntax Access Level Modifier
extension DeclGroupSyntax {
    /// Returns access level modifier as `String`.
    ///
    ///     let accessLevelModifier: String? = declaration.accessLevelModifier // "public"
    ///
    public var accessLevelModifier: String? {
        for modifier in modifiers {
            switch modifier.name.tokenKind {
            case .keyword(.open): return "open"
            case .keyword(.public): return "public"
            case .keyword(.internal): return "internal"
            case .keyword(.fileprivate): return "fileprivate"
            case .keyword(.private): return "private"
            default: continue
            }
        }

        return nil
    }
}
