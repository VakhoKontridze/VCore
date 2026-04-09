//
//  CodingKeysGeneration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation

/// Adds `CodingKeys` to a declaration.
///
/// If `accessLevelModifier` is `nil`, it will be inherited from the type.
///
///     @CodingKeysGeneration
///     nonisolated struct GetPostGatewayOutput: Decodable {
///         @CKGProperty let id: Int
///         @CKGProperty("userId") let userID: Int
///         @CKGProperty let title: String
///         @CKGProperty let body: String
///
///         var attributes: [String: Any] = [:]
///     }
///
///     // Generates
///     nonisolated internal enum CodingKeys: String, CodingKey {
///         case id = "id"
///         case userID = "userId"
///         case title = "title"
///         case body = "body"
///     }
///
@attached(member, names: named(CodingKeys))
public macro CodingKeysGeneration(
    accessLevelModifier: AccessLevelModifierKeyword? = nil
) = #externalMacro(
    module: "VCoreMacrosImplementation",
    type: "CodingKeysGenerationMacro"
)

/// Attaches custom `Codable` key to a property.
///
/// For additional info, refer to `CodingKeysGeneration`.
@attached(peer)
public macro CKGProperty(
    _ key: String? = nil
) = #externalMacro(
    module: "VCoreMacrosImplementation",
    type: "CKGPropertyMacro"
)
