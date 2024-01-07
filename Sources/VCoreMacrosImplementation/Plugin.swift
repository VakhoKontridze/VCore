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
@main struct Plugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        URLMacro.self
    ]
}
