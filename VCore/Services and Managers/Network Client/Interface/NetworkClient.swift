//
//  NetworkClient.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - Network Client
/// Network client that performs network data tasks.
///
/// Object contains default `default` instance, that can be used to make requests.
///
/// If additional processing is required, object can be extended the following way.
///
///     extension NetworkClient {
///         static let someInstance: NetworkClient = .init(
///             processor: SomeNetworkClientProcessor()
///         )
///     }
///
///     struct SomeNetworkError: Error {
///         let domain: String = "com.somecompany.someapp"
///         var code: Int
///         var description: String
///     }
///
///     struct SomeNetworkClientProcessor: NetworkClientProcessor {
///         func error(_ error: Error) throws {}
///
///         func response(_ data: Data, _ response: URLResponse) throws -> URLResponse {
///             if response.isSuccessHTTPStatusCode { return response }
///
///             guard let json: [String: Any?] = try? JSONDecoderService.json(from: data) else { return response }
///             if json["success"]?.toBool == true { return response }
///
///             guard
///                 let code: Int = json["code"]?.toInt,
///                 let description: String = json["message"]?.toString
///             else {
///                 throw SomeNetworkError(code: 99, description: "Unknown Error")
///             }
///
///             throw SomeNetworkError(code: code, description: description)
///         }
///
///         func data(_ data: Data, _ response: URLResponse) throws -> Data {
///             let json: [String: Any?] = try JSONDecoderService.json(from: data)
///             guard let dataJSON: [String: Any?] = json["data"]?.toJSON else { throw SomeNetworkError(code: 1, description: "Incomplete Data") }
///
///             let dataData: Data = try JSONEncoderService.data(from: dataJSON)
///
///             return dataData
///         }
///     }
///
/// Usage example:
///
///     do {
///         var request: NetworkRequest = .init(url: "https://httpbin.org/post")
///
///         request.method = .POST
///
///         try request.addHeaders([
///             "Accept": "application/json",
///             "Content-Type": "application/json"
///         ])
///
///         try request.addBody([
///             "someKey": "someValue"
///         ])
///
///         let result: [String: Any?] = try await NetworkClient.someInstance.json(from: request)
///
///         print(result["someKey"]?.toString ?? "-")
///
///     } catch let error {
///         print(error.localizedDescription)
///     }
///
public final class NetworkClient {
    // MARK: Properties
    /// Default instance of `NetworkClient`.
    public static let `default`: NetworkClient = .init(
        processor: DefaultNetworkProcessor()
    )
    
    /// Configuration object that defines behavior and policies for an `URL` session.
    public var sessionConfiguration: URLSessionConfiguration = .default
    
    private let processor: NetworkProcessor
    
    // MARK: Initializers
    /// Initializes `NetworkClient`.
    public init(processor: NetworkProcessor) {
        self.processor = processor
    }
    
    // MARK: Data Tasks
    /// Makes network request.
    public func noData(
        from request: NetworkRequest
    ) async throws {
        try await makeRequest(
            request: request
        )
    }
    
    /// Makes network request and returns `Data`.
    public func data(
        from request: NetworkRequest
    ) async throws -> Data {
        try await makeRequest(
            request: request,
            decode: { $0 }
        )
    }
    
    /// Makes network request and returns `JSON`.
    public func json(
        from request: NetworkRequest
    ) async throws -> [String: Any?] {
        try await makeRequest(
            request: request,
            decode: { try JSONDecoderService.json(from: $0) }
        )
    }
    
    /// Makes network request and returns `JSON` `Array`.
    public func jsonArray(
        from request: NetworkRequest
    ) async throws -> [[String: Any?]] {
        try await makeRequest(
            request: request,
            decode: { try JSONDecoderService.jsonArray(from: $0) }
        )
    }
    
    /// Makes network request and returns `Decodable`.
    public func decodable<DecodableEntity: Decodable>(
        from request: NetworkRequest
    ) async throws -> DecodableEntity {
        try await makeRequest(
            request: request,
            decode: { try JSONDecoderService.decodable(from: $0) }
        )
    }

    // MARK: Requests
    private func makeRequest<Entity>(
        request: NetworkRequest,
        decode: @escaping (Data) throws -> Entity
    ) async throws -> Entity {
        guard NetworkReachabilityService.isConnectedToNetwork else { throw NetworkError.notConnectedToNetwork }
        
        let urlRequest: URLRequest = try URLRequestFactory.build(
            endpoint: request.url,
            method: request.method.httpMethod,
            pathParameters: request.pathParameters,
            headers: request.headers,
            queryParameters: request.queryParameters,
            body: request.body.nonEmpty
        )

        do {
            let (data, response): (Data, URLResponse) = try await data(
                request: urlRequest,
                configuration: sessionConfiguration
            )

            let processedResponse: URLResponse = try processor.response(data, response)
            guard processedResponse.isSuccessHTTPStatusCode else { throw NetworkError.invalidResponse }

            let processedData: Data = try processor.data(data, response)
            guard let entity: Entity = try? decode(processedData) else { throw NetworkError.invalidData }

            return entity

        } catch let error {
            try processor.error(error)
            throw error
        }
    }
    
    // This method solely exists as for `noData` method
    private func makeRequest(
        request: NetworkRequest
    ) async throws {
        guard NetworkReachabilityService.isConnectedToNetwork else { throw NetworkError.notConnectedToNetwork }
        
        let urlRequest: URLRequest = try URLRequestFactory.build(
            endpoint: request.url,
            method: request.method.httpMethod,
            pathParameters: request.pathParameters,
            headers: request.headers,
            queryParameters: request.queryParameters,
            body: request.body.nonEmpty
        )

        do {
            let (data, response): (Data, URLResponse) = try await data(
                request: urlRequest,
                configuration: sessionConfiguration
            )

            let processedResponse: URLResponse = try processor.response(data, response)
            guard processedResponse.isSuccessHTTPStatusCode else { throw NetworkError.invalidResponse }

        } catch let error {
            try processor.error(error)
            throw error
        }
    }

    // func data(for request: URLRequest, delegate: URLSessionTaskDelegate? = nil) async throws -> (Data, URLResponse)
    private func data(
        request: URLRequest,
        configuration: URLSessionConfiguration
    ) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation({ continuation in
            let task: URLSessionDataTask = URLSession(configuration: configuration).dataTask(
                with: request,
                completionHandler: { (data, response, error) in
                    if let error = error {
                        if
                            (error as NSError).domain == NSURLErrorDomain &&
                            (error as NSError).code == NSURLErrorTimedOut
                        {
                            continuation.resume(throwing: NetworkError.requestTimedOut)
                            return
                            
                        } else {
                            continuation.resume(throwing: NetworkError.returnedWithError)
                            return
                        }
                    }
                    
                    guard let response = response else {
                        continuation.resume(throwing: NetworkError.invalidResponse)
                        return
                    }
                    
                    guard let data = data else {
                        continuation.resume(throwing: NetworkError.invalidData)
                        return
                    }
                    
                    continuation.resume(returning: (data, response))
                }
            )
            
            task.resume()
        })
    }
}

// MARK: - Helpers
extension Data {
    fileprivate var nonEmpty: Data? {
        guard count != 0 else { return nil }
        return self
    }
}
