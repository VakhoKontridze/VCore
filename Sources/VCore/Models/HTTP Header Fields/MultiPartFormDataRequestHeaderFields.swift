//
//  MultipartFormDataRequestHeaderFields.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.04.22.
//

import Foundation

// MARK: - Multipart Form Data Request Header Fields
/// JSON request header fields that pass `application/json` as `accept` and `multipart/form-data; boundary=\(boundary)` as `contentType`.
///
/// Can be used in `URLRequest` with `MultipartFormDataBuilder`.
///
///     var request: URLRequest = ...
///     try request.addHTTPHeaderFields(object: MultipartFormDataRequestHeaderFields(
///         boundary: boundary
///     ))
///
@CodingKeysGeneration
public struct MultipartFormDataRequestHeaderFields: Encodable {
    // MARK: Properties
    /// Accept. Set to `application/json`.
    @CKGCodingKey("Accept") public let accept: String = "application/json"

    /// Content type.
    @CKGCodingKey("Content-Type") public let contentType: String

    // MARK: Initializers
    /// Initializes `MultipartFormDataRequestHeaderFields` with boundary.
    public init(boundary: String) {
        self.contentType = "multipart/form-data; boundary=\(boundary)"
    }
    
    // MARK: Codable
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
