//
//  MultipartFormDataAuthorizedRequestHeaderFields.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.04.22.
//

import Foundation

// MARK: - Multipart Form Data Authorized Request Header Fields
/// JSON request header fields that pass `application/json` as `accept`, `multipart/form-data; boundary=\(boundary)` as `contentType`, and `authorization` as `Bearer \(token)`.
///
/// Can be used in `URLRequest` with `MultipartFormDataBuilder`.
///
///     var request: URLRequest = ...
///     try request.addHTTPHeaderFields(object: MultipartFormDataAuthorizedRequestHeaderFields(
///         boundary: boundary,
///         token: "token"
///     ))
///
@CodingKeysGeneration
public struct MultipartFormDataAuthorizedRequestHeaderFields: Encodable {
    // MARK: Properties
    /// Accept. Set to `application/json`.
    @CKGCodingKey("Accept") public let accept: String = "application/json"

    /// Content type.
    @CKGCodingKey("Content-Type") public let contentType: String

    /// Authorization.
    @CKGCodingKey("Authorization") public let authorization: String

    // MARK: Initializers
    /// Initializes `MultipartFormDataRequestHeaderFields` with boundary and token.
    public init(boundary: String, token: String) {
        self.contentType = "multipart/form-data; boundary=\(boundary)"
        self.authorization = "Bearer \(token)"
    }
    
    // MARK: Encodable
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        do {
            try container.encode(accept, forKey: .accept)
            try container.encode(contentType, forKey: .contentType)
            try container.encode(authorization, forKey: .authorization)
            
        } catch {
            VCoreLogError(error)
            throw error
        }
    }
}
