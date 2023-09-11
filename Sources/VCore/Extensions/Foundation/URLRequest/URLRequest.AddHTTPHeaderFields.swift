//
//  URLRequest.AddHTTPHeaderFields.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import Foundation

// MARK: - URL Request Add HTTP Header Fields
extension URLRequest {
    /// Adds `Dictionary` of `String` to `String` to the header fields.
    ///
    ///     var request: URLRequest = ...
    ///     request.addHTTPHeaderFields(["key": "value"])
    ///
    public mutating func addHTTPHeaderFields(
        _ httpHeaderFields: [String: String?]
    ) {
        for (key, value) in httpHeaderFields {
            guard let value else { continue }

            addValue(value, forHTTPHeaderField: key)
        }
    }

    /// Adds `JSON` to the header fields.
    ///
    ///     var request: URLRequest = ...
    ///     request.addHTTPHeaderFields(json: ["key": "value"])
    ///
    public mutating func addHTTPHeaderFields(
        json httpHeaderFields: [String: Any?]
    ) {
        for (key, value) in httpHeaderFields {
            guard
                let value,
                let valueStr: String = .init(unwrappedDescribing: value)
            else {
                continue
            }

            addValue(valueStr, forHTTPHeaderField: key)
        }
    }

    /// Adds `Encodable` value to the header fields.
    ///
    ///     var request: URLRequest = ...
    ///     try request.addHTTPHeaderFields(object: JSONRequestHeaderFields())
    ///
    public mutating func addHTTPHeaderFields(
        object: some Encodable
    ) throws {
        addHTTPHeaderFields(json: try JSONEncoder().encodeObjectToJSON(object))
    }
}
