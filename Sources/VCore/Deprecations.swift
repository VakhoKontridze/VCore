//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import SwiftUI

// MARK: - Macros
@available(*, deprecated, renamed: "Uninitializable")
@attached(member, names: named(init))
public macro NonInitializable() = #externalMacro(
    module: "VCoreMacros",
    type: "UninitializableMacro"
)

