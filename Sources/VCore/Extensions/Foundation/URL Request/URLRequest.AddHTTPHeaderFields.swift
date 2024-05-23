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
    mutating public func addHTTPHeaderFields(
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
    mutating public func addHTTPHeaderFields(
        json httpHeaderFields: [String: Any?]
    ) {
        for (key, value) in httpHeaderFields {
            guard let value else { continue }

            let valueStr: String = .init(describing: value)

            addValue(valueStr, forHTTPHeaderField: key)
        }
    }

    /// Adds `Encodable` value to the header fields.
    ///
    ///     var request: URLRequest = ...
    ///     try request.addHTTPHeaderFields(object: JSONRequestHeaderFields())
    ///
    mutating public func addHTTPHeaderFields(
        object: some Encodable
    ) throws {
        addHTTPHeaderFields(json: try JSONEncoder().encodeObjectToJSON(object))
    }
}
