//
//  UninitializableMacro.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation

// MARK: - Uninitializable Macro
/// Adds `private` initializer to declaration, preventing object creation.
///
/// Can be used to simplify declarations of simple objects containing various constants.
///
///     @Uninitializable
///     struct AppConstants {
///         static let apiKey: String = "..."
///     }
///
@attached(member, names: named(init))
public macro Uninitializable() = #externalMacro(
    module: "VCoreMacros",
    type: "UninitializableMacro"
)
