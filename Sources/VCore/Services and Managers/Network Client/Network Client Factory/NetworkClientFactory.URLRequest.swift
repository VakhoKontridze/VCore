//
//  NetworkClientFactory.URLRequest.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/19/21.
//

import Foundation

// MARK: - URL Request Factory
extension NetworkClientFactory {
    struct URLRequest {
        // MARK: Initializers
        private init() {}
        
        // MARK: Building
        static func build(
            endpoint: String,
            method: String,
            pathParameters: [String],
            headers: [String: String],
            queryParameters: [String: String],
            body: Data?
        ) throws -> Foundation.URLRequest {
            let endpoint: String = buildEndpoint(endpoint: endpoint, pathParameters: pathParameters)
            let url: URL = try buildUrl(endpoint: endpoint, queryParameters: queryParameters) // Logged internally
            
            var urlRequest: Foundation.URLRequest = .init(url: url)
            urlRequest.httpMethod = method
            urlRequest.addHTTPHeaders(headers)
            urlRequest.httpBody = body?.nonEmpty
            return urlRequest
        }
        
        static func build(
            from request: NetworkRequest
        ) throws -> Foundation.URLRequest {
            try build( // Logged internally
                endpoint: request.url,
                method: request.method.httpMethod,
                pathParameters: request.pathParameters,
                headers: request.headers,
                queryParameters: request.queryParameters,
                body: request.body
            )
        }
        
        private static func buildEndpoint(
            endpoint: String,
            pathParameters: [String]
        ) -> String {
            var endpoint = endpoint
            if endpoint.hasSuffix("/") { _ = endpoint.removeLast() }
            
            for pathParameter in pathParameters {
                endpoint.append("/\(pathParameter)")
            }
            
            return endpoint
        }
        
        private static func buildUrl(
            endpoint: String,
            queryParameters: [String: String]
        ) throws -> URL {
            guard var urlComponents: URLComponents = .init(string: endpoint) else {
                let error: NetworkClientError = .init(.invalidEndpoint)
                VCoreLog(error)
                throw error
            }
            
            urlComponents.addQueryItems(queryParameters)
            
            guard let url: URL = urlComponents.url else {
                let error: NetworkClientError = .init(.invalidQueryParameters)
                VCoreLog(error)
                throw error
            }
            return url
        }
    }
}

// MARK: - Helpers - Query Parameters
extension URLComponents {
    fileprivate mutating func addQueryItems(_ newQueryItems: [String: String?]) {
        guard !newQueryItems.isEmpty else { return }

        switch queryItems {
        case nil: queryItems = newQueryItems.compactMap { .init($0) }
        case _?: newQueryItems.compactMap { URLQueryItem($0) }.forEach { queryItems?.append($0) }
        }
    }
}

extension URLQueryItem {
    fileprivate init?(_ queryItem: Dictionary<String, String?>.Element) {
        guard let value: String = queryItem.value else { return nil }
        self.init(name: queryItem.key, value: value)
    }
}

// MARK: - Helpers - Headers
extension URLRequest {
    fileprivate mutating func addHTTPHeaders(_ items: [String: String?]) {
        guard !items.isEmpty else { return }
        
        items.forEach { (key, value) in
            guard let value else { return }
            addValue(value, forHTTPHeaderField: key)
        }
    }
}

// MARK: - Helpers - Body
extension Data {
    fileprivate var nonEmpty: Data? {
        guard count != 0 else { return nil }
        return self
    }
}
