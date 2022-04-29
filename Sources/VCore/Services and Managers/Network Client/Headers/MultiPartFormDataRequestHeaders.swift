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
    enum CodingKeys: String, CodingKey {
        case accept = "Accept"
        case contentType = "Content-Type"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(accept, forKey: .accept)
        try container.encode(contentType, forKey: .contentType)
    }
}
