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
    /// Initializes `NetworkRequest` with URL string.
    public init(url: String) {
        self.url = url
    }
    
    /// Initializes `NetworkRequest` with URL.
    public init(url: URL) {
        self.init(url: url.absoluteString)
    }

    // MARK: Path Parameters
    /// Adds `String` `Array` to path parameters.
    public mutating func addPathParameters(
        _ stringArray: [String]
    ) {
        pathParameters.append(contentsOf: NetworkRequestFactory.PathParameters.build(stringArray))
    }
    
    // MARK: Query Parameters
    /// Adds `String` `Array` to query parameters.
    public mutating func addQueryParameters(
        _ json: [String: Any?]
    ) throws {
        queryParameters.append(try NetworkRequestFactory.QueryParameters.build(json))
    }

    /// Adds `Encodable` to query parameters.
    public mutating func addQueryParameters<EncodableQueryParameters: Encodable>(
        _ encodable: EncodableQueryParameters
    ) throws {
        queryParameters.append(try NetworkRequestFactory.QueryParameters.build(encodable))
    }

    // MARK: Headers
    /// Adds `JSON` to headers.
    public mutating func addHeaders(
        _ json: [String: String?]
    ) {
        headers.append(NetworkRequestFactory.Headers.build(json))
    }

    /// Adds `Encodable` to headers.
    public mutating func addHeaders<EncodableHeaders: Encodable>(
        _ encodable: EncodableHeaders
    ) throws {
        headers.append(try NetworkRequestFactory.Headers.build(encodable))
    }
    
    // MARK: Body
    /// Adds `Data` to body.
    public mutating func addBody(
        _ data: Data
    ) {
        body.append(NetworkRequestFactory.Body.build(data))
    }

    /// Adds `JSON` to headers.
    public mutating func addBody(
        _ json: [String: Any?]
    ) throws {
        body.append(try NetworkRequestFactory.Body.build(json))
    }

    /// Adds `Encodable` to headers.
    public mutating func addBody<EncodableBody: Encodable>(
        _ encodable: EncodableBody
    ) throws {
        body.append(try NetworkRequestFactory.Body.build(encodable))
    }
}

// MARK: - Helpers
extension Dictionary {
    fileprivate mutating func append(_ other: Dictionary) {
        for (key, value) in other {
            updateValue(value, forKey: key)
        }
    }
}
