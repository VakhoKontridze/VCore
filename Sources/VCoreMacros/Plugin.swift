//
//  Plugin.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 07.01.24.
//

import Foundation
import SwiftCompilerPlugin
import SwiftSyntaxMacros

// MARK: - Plugin
@main struct Plugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        // Attached
        CaseDetectionMacro.self,
        CodingKeysGenerationMacro.self, CKGCodingKeyMacro.self, CKGCodingKeyIgnoredMacro.self,
        NonInitializableMacro.self,
        OptionSetRepresentationMacro.self,

        // Freestanding (Declaration)
        // ...

        // Freestanding (Expression)
        ColorMacro_InitWithHexString.self,
        ColorMacro_InitWithHexUInt.self,
        URLMacro_InitWithString.self
    ]
}
