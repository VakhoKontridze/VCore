//
//  MemberwiseCodableMacro.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation

// MARK: - Memberwise Codable Macro
/// Adds `CodingKeys` to a declaration to memberwise code each property.
///
///     @MemberwiseCodable
///     struct GetPostEntity: Decodable {
///         @MWCCodingKey("id") let id: Int
///         @MWCCodingKey("userId") let userID: Int
///         @MWCCodingKey("title") let title: String
///         @MWCCodingKey("body") let body: String
///
///         @MWCCodingKeyIgnored var attributes: [String: Any?] = [:]
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
@attached(member, names: named(CodingKeys), named(CodingKey), named(MWCCodingKeyIgnored))
public macro MemberwiseCodable(
    accessLevelModifier: String = "internal"
) = #externalMacro(
    module: "VCoreMacros",
    type: "MemberwiseCodableMacro"
)

// MARK: - Memberwise Codable Coding Key Macro
/// Attaches custom `Codable` key to a property.
///
/// For more information, refer to `MemberwiseCodable`.
@attached(peer)
public macro MWCCodingKey(
    _ key: String
) = #externalMacro(
    module: "VCoreMacros",
    type: "MWCCodingKeyMacro"
)

// MARK: - Membewise Codable Coding Key Ignored Macro
/// Ignores generation of ucstom `Codable` key for a property.
///
/// For more information, refer to `MemberwiseCodable`.
@attached(peer)
public macro MWCCodingKeyIgnored() = #externalMacro(
    module: "VCoreMacros",
    type: "MWCCodingKeyIgnoredMacro"
)
