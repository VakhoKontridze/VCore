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
///     try request.addHTTPHeaderFields(
///         object: MultipartFormDataRequestHeaderFields(
///             boundary: boundary
///         )
///     )
///
@CodingKeysGeneration
public struct MultipartFormDataRequestHeaderFields: Encodable {
    // MARK: Properties
    /// Accept. Set to `application/json`.
    @CKGProperty("Accept") public let accept: String = "application/json"

    /// Content type.
    @CKGProperty("Content-Type") public let contentType: String

    // MARK: Initializers
    /// Initializes `MultipartFormDataRequestHeaderFields` with boundary.
    public init(boundary: String) {
        self.contentType = "multipart/form-data; boundary=\(boundary)"
    }
}
