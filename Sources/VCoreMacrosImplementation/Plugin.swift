//
//  Plugin.swift
//  VCoreMacrosImplementation
//
//  Created by Vakhtang Kontridze on 07.01.24.
//

import Foundation
import SwiftCompilerPlugin
import SwiftSyntaxMacros

// MARK: - Plugin
@main 
struct Plugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        // Attached
        CodingKeysGenerationMacro.self, CKGPropertyMacro.self,
        MemberwiseInitializableMacro.self,
        OptionSetRepresentationMacro.self,
        UninitializableMacro.self,

        // Freestanding (Declaration)
        // ...

        // Freestanding (Expression)
        ColorMacro_InitWithHexString.self,
        ColorMacro_InitWithHexUInt.self,
        URLMacro_InitWithString.self
    ]
}
