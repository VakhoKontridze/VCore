//
//  CodingKeysGeneration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation

// MARK: - Coding Keys Generation
/// Adds `CodingKeys` to a declaration.
///
///     @CodingKeysGeneration
///     struct GetPostEntity: Decodable {
///         @CKGProperty("id") let id: Int
///         @CKGProperty("userId") let userID: Int
///         @CKGProperty("title") let title: String
///         @CKGProperty("body") let body: String
///
///         var attributes: [String: Any?] = [:]
///     }
///
///     // Generates
///     internal enum CodingKeys: String, CodingKey {
///         case id = "id"
///         case userID = "userId"
///         case title = "title"
///         case body = "body"
///     }
///
@attached(member, names: named(CodingKeys))
public macro CodingKeysGeneration(
    accessLevelModifier: AccessLevelModifierKeyword = .internal
) = #externalMacro(
    module: "VCoreMacrosImplementation",
    type: "CodingKeysGenerationMacro"
)

// MARK: - Coding Keys Generation Coding Key
/// Attaches custom `Codable` key to a property.
///
/// For additional info, refer to `CodingKeysGeneration`.
@attached(peer)
public macro CKGProperty(
    _ key: String
) = #externalMacro(
    module: "VCoreMacrosImplementation",
    type: "CKGPropertyMacro"
)
