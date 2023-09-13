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
///     try request.addHTTPHeaderFields(object: JSONAuthorizedRequestHeaderFields(
///         token: "token"
///     ))
///
public struct JSONAuthorizedRequestHeaderFields: Encodable {
    // MARK: Properties
    /// Accept. Set to `application/json`.
    public let accept: String = "application/json"
    
    /// Content type. Set to `application/json`.
    public let contentType: String = "application/json"
    
    /// Authorization
    public let authorization: String
    
    // MARK: Initializers
    /// Initializes `JSONAuthorizedRequestHeaderFields` with token.
    public init(token: String) {
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