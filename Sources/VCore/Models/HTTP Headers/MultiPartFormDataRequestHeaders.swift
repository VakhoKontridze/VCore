//
//  MultiPartFormDataRequestHeaders.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.04.22.
//

import Foundation

// MARK: - Multi Part Form Data Request Headers
/// JSON request headers that pass `application/json` as `accept` and `multipart/form-data; boundary=\(boundary)` as `contentType`.
///
/// Can be used in `NetworkClient` with `MultiPartFormDataBuilder`.
///
///     var request: NetworkRequest = .init(url: ...)
///     try request.addHeaders(encodable: MultiPartFormDataRequestHeaders(
///         boundary: boundary
///     ))
///
public struct MultiPartFormDataRequestHeaders: Encodable {
    // MARK: Properties
    /// Accept. Defaults to `application/json`.
    public let accept: String = "application/json"
    
    /// Content type.
    public let contentType: String
    
    // MARK: Initializers
    /// Initializes `MultiPartFormDataRequestHeaders` with boundary.
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
            VCoreLog(error)
            throw error
        }
    }
}
