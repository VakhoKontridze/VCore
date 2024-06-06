//
//  JSONAuthorizedRequestHeaderFields.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.04.22.
//

import Foundation

// MARK: - JSON Authorized Request Header Fields
/// Authorized JSON request header fields that pass `application/json` as `accept`, `application/json` as `contentType`, and `authorization` as `Bearer \(token)`.
///
/// Can be used in `URLRequest`.
///
///     var request: URLRequest = ...
///     try request.addHTTPHeaderFields(
///         object: JSONAuthorizedRequestHeaderFields(
///             token: "token"
///         )
///     )
///
@CodingKeysGeneration
public struct JSONAuthorizedRequestHeaderFields: Encodable {
    // MARK: Properties
    /// Accept. Set to `application/json`.
    @CKGProperty("Accept") public let accept: String = "application/json"

    /// Content type. Set to `application/json`.
    @CKGProperty("Content-Type") public let contentType: String = "application/json"

    /// Authorization.
    @CKGProperty("Authorization") public let authorization: String

    // MARK: Initializers
    /// Initializes `JSONAuthorizedRequestHeaderFields` with token.
    public init(token: String) {
        self.authorization = "Bearer \(token)"
    }
}
