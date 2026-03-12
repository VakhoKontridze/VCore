//
//  URL+InitWithPathAndQueryParameters.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import Foundation

extension URL {
    /// Initializes `URL` with `String`, path parameters, and query parameters.
    ///
    ///     let url: URL = .init(
    ///         string: "https://website.com",
    ///         pathParameters: ["path", "to", "resource"],
    ///         queryParameters: [
    ///             ("key1", "value1"),
    ///             ("key2", "value2")
    ///         ]
    ///     )!
    ///
    ///     "https://website.com/path/to/resource?key1=value1&key2=value2"
    ///
    public init?(
        string: String,
        pathParameters: [String],
        queryParameters: [(key: String, value: String)]
    ) {
        var string = string
        if string.hasSuffix("/") { _ = string.removeLast() }

        guard !string.isEmpty else { return nil }

        pathParameters.forEach { string.append("/\($0)") }

        guard var urlComponents: URLComponents = .init(string: string) else { return nil }
        urlComponents.addQueryItems(queryParameters)

        guard let url: URL = urlComponents.url else { return nil }

        self = url
    }
}

extension URLComponents {
    fileprivate mutating func addQueryItems(
        _ newQueryItems: [(key: String, value: String)]
    ) {
        guard !newQueryItems.isEmpty else { return }

        let newURLQueryItems: [URLQueryItem] = newQueryItems.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }

        if queryItems == nil {
            queryItems = newURLQueryItems
        } else {
            queryItems?.append(contentsOf: newURLQueryItems)
        }
    }
}
