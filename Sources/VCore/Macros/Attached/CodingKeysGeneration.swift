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
///         @CKGCodingKey("id") let id: Int
///         @CKGCodingKey("userId") let userID: Int
///         @CKGCodingKey("title") let title: String
///         @CKGCodingKey("body") let body: String
///
///         @CKGCodingKeyIgnored var attributes: [String: Any?] = [:]
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
@attached(member, names: named(CodingKeys), named(CodingKey), named(CKGCodingKeyIgnored))
public macro CodingKeysGeneration(
    accessLevelModifier: String = "internal"
) = #externalMacro(
    module: "VCoreMacros",
    type: "CodingKeysGenerationMacro"
)

// MARK: - Coding Keys Generation Coding Key
/// Attaches custom `Codable` key to a property.
///
/// For additional info, refer to `CodingKeysGeneration`.
@attached(peer)
public macro CKGCodingKey(
    _ key: String
) = #externalMacro(
    module: "VCoreMacros",
    type: "CKGCodingKeyMacro"
)

// MARK: - Coding Keys Generation Coding Key Ignored
/// Ignores generation of ucstom `Codable` key for a property.
///
/// For additional info, refer to `CodingKeysGeneration`.
@attached(peer)
public macro CKGCodingKeyIgnored() = #externalMacro(
    module: "VCoreMacros",
    type: "CKGCodingKeyIgnoredMacro"
)
