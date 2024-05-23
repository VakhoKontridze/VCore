//
//  MemberwiseInitializable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.05.24.
//

import Foundation

// MARK: - Memberwise Initializable
/// Generates memberwise initializer.
///
///     @MemberwiseInitializable(
///         accessLevelModifier: .public,
///         externalParameterNames: ["url": "_"]
///     )
///     public struct FetchImageParameters {
///         public let url: String
///         public let completion: (String) async throws -> UIImage
///     }
///
///     // Generates
///     public init(
///         _ url: String,
///         completion: @escaping (String) async throws -> UIImage
///     ) {
///         self.url = url
///         self.completion = completion
///     }
///
@attached(member, names: named(init))
public macro MemberwiseInitializable(
    accessLevelModifier: AccessLevelModifierKeyword = .internal,
    externalParameterNames: [String: String] = [:],
    parameterDefaultValues: [String: MemberwiseInitializableParameterDefaultValue] = [:],
    excludedParameters: [String] = [],
    comment: String? = nil
) = #externalMacro(
    module: "VCoreMacros",
    type: "MemberwiseInitializableMacro"
)

// MARK: - Memberwise Initializable Parameter Default Value
/// Enumeration that represents parameter default value.
public enum MemberwiseInitializableParameterDefaultValue {
    /// Value.
    case value(Any?)

    /// Omitted value.
    case omit
}
