//
//  MultipartFormDataRequestHeaders.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.04.22.
//

import Foundation

// MARK: - Multipart Form Data Request Headers
/// JSON request headers that pass `application/json` as `accept` and `multipart/form-data; boundary=\(boundary)` as `contentType`.
///
/// Can be used in `URLRequest` with `MultipartFormDataBuilder`.
///
///     var request: URLRequest = ...
///     try request.addHTTPHeaderFields(object: MultipartFormDataRequestHeaders(
///         boundary: boundary
///     ))
///
public struct MultipartFormDataRequestHeaders: Encodable {
    // MARK: Properties
    /// Accept. Set to `application/json`.
    public let accept: String = "application/json"
    
    /// Content type.
    public let contentType: String
    
    // MARK: Initializers
    /// Initializes `MultipartFormDataRequestHeaders` with boundary.
    public init(boundary: String) {
        self.contentType = "multipart/form-data; boundary=\(boundary)"
    }
    
    // MARK: Coding Keys
    private enum CodingKeys: String, CodingKey {
        case accept = "Accept"
        case contentType = "Content-Type"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        do {
            try container.encode(accept, forKey: .accept)
            try container.encode(contentType, forKey: .contentType)
            
        } catch {
            VCoreLogError(error)
            throw error
        }
    }
}
