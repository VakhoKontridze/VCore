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
        pathParameters.append(contentsOf: NetworkRequestFactory.PathParameters.build(string: string))
    }
    
    /// Adds `String` `Array` to path parameters.
    mutating public func addPathParameters(
        stringArray: [String]
    ) {
        pathParameters.append(contentsOf: NetworkRequestFactory.PathParameters.build(stringArray: stringArray))
    }
    
    // MARK: Query Parameters
    /// Adds `String` `Array` to query parameters.
    mutating public func addQueryParameters(
        json: [String: Any?]
    ) throws {
        queryParameters.append(try NetworkRequestFactory.QueryParameters.build(json: json))
    }

    /// Adds `Encodable` to query parameters.
    mutating public func addQueryParameters<T: Encodable>(
        encodable: T
    ) throws {
        queryParameters.append(try NetworkRequestFactory.QueryParameters.build(encodable: encodable))
    }

    // MARK: Headers
    /// Adds `JSON` to headers.
    mutating public func addHeaders(
        json: [String: String?]
    ) {
        headers.append(NetworkRequestFactory.Headers.build(json: json))
    }

    /// Adds `Encodable` to headers.
    mutating public func addHeaders<T: Encodable>(
        encodable: T
    ) throws {
        headers.append(try NetworkRequestFactory.Headers.build(encodable: encodable))
    }
    
    // MARK: Body
    /// Adds `Data` to body.
    mutating public func addBody(
        data: Data
    ) {
        body.append(NetworkRequestFactory.Body.build(data: data))
    }

    /// Adds `JSON` to headers.
    mutating public func addBody(
        json: [String: Any?]
    ) throws {
        body.append(try NetworkRequestFactory.Body.build(json: json))
    }

    /// Adds `Encodable` to headers.
    mutating public func addBody<T: Encodable>(
        encodable: T
    ) throws {
        body.append(try NetworkRequestFactory.Body.build(encodable: encodable))
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
