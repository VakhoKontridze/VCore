//
//  EnvironmentValueGeneration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 19.04.24.
//

import Foundation

// MARK: - Environment Value Generation
/// Adds `EnvironmentKey` to a declaration.
///
///     extension EnvironmentValues {
///         @EnvironmentValueGeneration var value: String = "Lorem ipsum"
///     }
///
///     @Environment(\.value) private var value: String
///
///     var body: some View {
///         Text(value)
///     }
///
@attached(peer, names: suffixed(_EnvironmentKey))
@attached(accessor, names: named(get), named(set))
public macro EnvironmentValueGeneration() = #externalMacro(
    module: "VCoreMacros",
    type: "EnvironmentValueGenerationMacro"
)
