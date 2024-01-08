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
///         @MWCKey("id") let id: Int
///         @MWCKey("userId") let userID: Int
///         @MWCKey("title") let title: String
///         @MWCKey("body") let body: String
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
@attached(member, names: named(CodingKeys), named(MWCKey))
public macro MemberwiseCodable(
    accessLevelModifier: String = "internal"
) = #externalMacro(
    module: "VCoreMacros",
    type: "MemberwiseCodableMacro"
)

// MARK: - Memberwise Codable Key Macro
/// Attaches custom `Codable` key to a property.
///
/// For more information, refer to `MemberwiseCodable`.
@attached(peer)
public macro MWCKey(
    _ key: String
) = #externalMacro(
    module: "VCoreMacros",
    type: "MWCKeyMacro"
)
