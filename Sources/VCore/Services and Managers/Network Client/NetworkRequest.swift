//
//  NetworkRequest.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/19/21.
//

import Foundation

// MARK: - Network Request
/// `URL` request executed by `NetworkClient`.
public struct NetworkRequest {
    // MARK: Properties
    /// `URL` of the request.
    public var url: String
    
    /// `HTTP` method. Defaults to `GET`.
    public var method: NetworkRequestMethod = .GET
    
    private(set) var pathParameters: [String] = []
    private(set) var queryParameters: [String: String] = [:]
    private(set) var headers: [String: String] = [:]
    private(set) var body: Data = .init()
    
    // MARK: Initializers
    /// Initializes `NetworkRequest` with URL `String`.
    public init(url: String) {
        self.url = url
    }
    
    /// Initializes `NetworkRequest` with URL.
    public init(url: URL) {
        self.init(url: url.absoluteString)
    }

    // MARK: Path Parameters
    /// Adds `String` to path parameters.
    mutating public func addPathParameters(
        string: String
    ) {
        pathParameters.append(string)
    }
    
    /// Adds `String` `Array` to path parameters.
    mutating public func addPathParameters(
        stringArray: [String]
    ) {
        pathParameters.append(contentsOf: stringArray)
    }
    
    // MARK: Query Parameters
    /// Adds `JSON` to query parameters.
    mutating public func addQueryParameters(
        json: [String: Any?]
    ) throws {
        for (key, value) in json {
            guard let value else { continue }
            
            guard let description: String = .init(unwrappedDescribing: value) else {
                let error: NetworkClientError = .init(.invalidQueryParameters)
                VCoreLog(error, "\(value) cannot be encoded as a query parameter")
                throw error
            }
            
            queryParameters[key] = description
        }
    }

    /// Adds `Encodable` to query parameters.
    mutating public func addQueryParameters(
        encodable: some Encodable,
        optionsDataToJSON: JSONSerialization.ReadingOptions = []
    ) throws {
        let json: [String: Any?]
        do {
            json = try JSONEncoderService().json(encodable: encodable, optionsDataToJSON: optionsDataToJSON)
            
        } catch /*let _error*/ { // Logged internally
            let error: NetworkClientError = .init(.invalidQueryParameters)
            VCoreLog(error)
            throw error
        }
        
        try addQueryParameters(json: json)
    }

    // MARK: Headers
    /// Adds `JSON` to headers.
    mutating public func addHeaders(
        json: [String: Any?]
    ) throws {
        for (key, value) in json {
            guard let value else { continue }
            
            guard let description: String = .init(unwrappedDescribing: value) else {
                let error: NetworkClientError = .init(.invalidHeaders)
                VCoreLog(error, "\(value) cannot be encoded as a header parameter")
                throw error
            }
            
            headers[key] = description
        }
    }

    /// Adds `Encodable` to headers.
    mutating public func addHeaders(
        encodable: some Encodable,
        optionsDataToJSON: JSONSerialization.ReadingOptions = []
    ) throws {
        let json: [String: Any?]
        do {
            json = try JSONEncoderService().json(encodable: encodable, optionsDataToJSON: optionsDataToJSON)
            
        } catch /*let _error*/ { // Logged internally
            let error: NetworkClientError = .init(.invalidHeaders)
            VCoreLog(error)
            throw error
        }
        
        try addHeaders(json: json)
    }
    
    // MARK: Body
    /// Adds `Data` to body.
    mutating public func addBody(
        data: Data
    ) {
        body.append(data)
    }

    /// Adds `JSON` to headers.
    mutating public func addBody(
        json: [String: Any?],
        options: JSONSerialization.WritingOptions = []
    ) throws {
        do {
            try body.append(JSONEncoderService().data(any: json, options: options))
            
        } catch /*let _error*/ { // Logged internally
            let error: NetworkClientError = .init(.invalidBody)
            VCoreLog(error)
            throw error
        }
    }

    /// Adds `Encodable` to headers.
    mutating public func addBody(
        encodable: some Encodable
    ) throws {
        do {
            try body.append(JSONEncoderService().data(encodable: encodable))

        } catch /*let _error*/ { // Logged internally
            let error: NetworkClientError = .init(.invalidBody)
            VCoreLog(error)
            throw error
        }
    }
    
    // MARK: URL Request
    func buildURLRequest() throws -> URLRequest {
        let url: URL = try .init(
            endpoint: url,
            pathParameters: pathParameters,
            queryParameters: queryParameters
        )
        
        var urlRequest: URLRequest = .init(url: url)
        urlRequest.httpMethod = method.httpMethod
        urlRequest.addHTTPHeaders(headers)
        urlRequest.httpBody = body.nonEmpty
        return urlRequest
    }
}

// MARK: - Helpers - URL Init
extension URL {
    fileprivate init(
        endpoint: String,
        pathParameters: [String],
        queryParameters: [String: String]
    ) throws {
        var endpoint = endpoint
        if endpoint.hasSuffix("/") { _ = endpoint.removeLast() }
        
        for pathParameter in pathParameters {
            endpoint.append("/\(pathParameter)")
        }
        
        guard var urlComponents: URLComponents = .init(string: endpoint) else {
            let error: NetworkClientError = .init(.invalidEndpoint)
            VCoreLog(error)
            throw error
        }
        
        urlComponents.addQueryItems(queryParameters)
        
        guard let url: URL = urlComponents.url else {
            let error: NetworkClientError = .init(.invalidEndpoint)
            VCoreLog(error)
            throw error
        }
        
        self = url
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
        for (key, value) in items {
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