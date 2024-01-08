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
        CaseDetectionMacro.self,
        MemberwiseCodableMacro.self, MWCKeyMacro.self,
        OptionSetRepresentationMacro.self,
        URLMacro.self
    ]
}
