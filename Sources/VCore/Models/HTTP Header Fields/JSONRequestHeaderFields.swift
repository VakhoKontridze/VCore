//
//  JSONRequestHeaderFields.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.04.22.
//

import Foundation

// MARK: - JSON Request Header Fields
/// JSON request header fields that pass `application/json` as `accept` and `application/json` as `contentType`.
///
/// Can be used in `URLRequest`.
///
///     var request: URLRequest = ...
///     try request.addHTTPHeaderFields(object: JSONRequestHeaderFields())
///
public struct JSONRequestHeaderFields: Encodable {
    // MARK: Properties
    /// Accept. Set to `application/json`.
    public let accept: String = "application/json"
    
    /// Content type. Set to `application/json`.
    public let contentType: String = "application/json"
    
    // MARK: Initializers
    /// initializes `JSONRequestHeaderFields`.
    public init() {}
    
    // MARK: Coding Keys
    private enum CodingKeys: String, CodingKey {
        case accept = "Accept"
        case contentType = "Content-Type"
    }
}
