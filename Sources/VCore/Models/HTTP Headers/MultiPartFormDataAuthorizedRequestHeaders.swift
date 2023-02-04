//
//  MultipartFormDataAuthorizedRequestHeaders.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.04.22.
//

import Foundation

// MARK: - Multipart Form Data Authorized Request Headers
/// JSON request headers that pass `application/json` as `accept`, `multipart/form-data; boundary=\(boundary)` as `contentType`, and `authorization` as `Bearer \(token)`.
///
/// Can be used in `NetworkClient` with `MultipartFormDataBuilder`.
///
///     var request: NetworkRequest = .init(url: ...)
///     try request.addHeaders(encodable: MultipartFormDataAuthorizedRequestHeaders(
///         boundary: boundary,
///         token: "token"
///     ))
///
public struct MultipartFormDataAuthorizedRequestHeaders: Encodable {
    // MARK: Properties
    /// Accept. Defaults to `application/json`.
    public let accept: String = "application/json"
    
    /// Content type.
    public let contentType: String
    
    /// Authorization.
    public let authorization: String
    
    // MARK: Initializers
    /// Initializes `MultipartFormDataRequestHeaders` with boundary and token.
    public init(boundary: String, token: String) {
        self.contentType = "multipart/form-data; boundary=\(boundary)"
        self.authorization = "Bearer \(token)"
    }
    
    // MARK: Coding Keys
    private enum CodingKeys: String, CodingKey {
        case accept = "Accept"
        case contentType = "Content-Type"
        case authorization = "Authorization"
    }
    
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
