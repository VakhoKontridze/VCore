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
/// If `accessLevelModifier` is `nil`, it will be inherited from the type.
///
/// You can use `"*": .omit` wildcard in `parameterDefaultValues` to remove all default values from parameters.
/// This is particularly useful when dealing with `Optional` properties, that by default, have `nil` values in initializer.
///
///     @MemberwiseInitializable(
///         externalParameterNames: ["url": "_"]
///     )
///     public struct FetchImageParameters: Sendable {
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
    accessLevelModifier: AccessLevelModifierKeyword? = nil,
    externalParameterNames: [String: String] = [:],
    parameterDefaultValues: [String: MemberwiseInitializableParameterDefaultValue] = [:],
    excludedParameters: [String] = [],
    comment: String? = nil
) = #externalMacro(
    module: "VCoreMacrosImplementation",
    type: "MemberwiseInitializableMacro"
)

// MARK: - Memberwise Initializable Parameter Default Value
/// Default parameter value in `MemberwiseInitializable`.
public enum MemberwiseInitializableParameterDefaultValue {
    /// Value.
    case value(Any?)

    /// Omitted value.
    case omit
}
