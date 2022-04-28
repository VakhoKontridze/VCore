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
/// Usage example:
///
///     struct JSONRequestHeaders: Encodable {
///         let accept: String = "application/json"
///         let contentType: String = "application/json"
///
///         enum CodingKeys: String, CodingKey {
///             case accept = "Accept"
///             case contentType = "Content-Type"
///         }
///     }
///
///     func fetchData() async {
///         do {
///             var request: NetworkRequest = .init(url: "https://httpbin.org/post")
///             
///             request.method = .POST
///
///             try request.addHeaders(JSONRequestHeaders())
///
///             try request.addBody([
///                 "someKey": "someValue"
///             ])
///
///             let result: [String: Any?] = try await NetworkClient.default.json(from: request)
///
///             print(result["json"]?.toJSON?["someKey"]?.toString ?? "-")
///
///         } catch {
///             print(error.localizedDescription)
///         }
///     }
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
///     struct SomeNetworkClientProcessor: NetworkResponseProcessor {
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
///             guard
///                 let json: [String: Any?] = try? JSONDecoderService.json(from: data),
///                 let dataJSON: [String: Any?] = json["data"]?.toJSON,
///                 let dataData: Data = try? JSONEncoderService.data(from: dataJSON)
///             else {
///                 throw SomeNetworkError(code: 1, description: "Incomplete Data")
///             }
///
///             return dataData
///         }
///     }
///
public final class NetworkClient {
    // MARK: Properties
    /// Default instance of `NetworkClient`.
    public static let `default`: NetworkClient = .init(
        responseProcessor: DefaultNetworkResponseProcessor()
    )
    
    /// Configuration object that defines behavior and policies for an `URL` session.
    public var sessionConfiguration: URLSessionConfiguration = .default
    
    private let responseProcessor: NetworkResponseProcessor
    
    // MARK: Initializers
    /// Initializes `NetworkClient`.
    public init(responseProcessor: NetworkResponseProcessor) {
        self.responseProcessor = responseProcessor
    }
    
    // MARK: Data Tasks (Async Throws)
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
    
    // MARK: Data Tasks (Result)
    /// Makes network calls completion handler with a result of success or `Error`.
    public func noData(
        from request: NetworkRequest,
        completion: @escaping (ResultNoSuccess<Error>) -> Void
    ) {
        Task(operation: {
            do {
                try await noData(from: request)
                completion(.success)
            } catch {
                completion(.failure(error))
            }
        })
    }
    
    /// Makes network request and calls completion handler with a result of `Data`or `Error`.
    public func data(
        from request: NetworkRequest,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        Task(operation: {
            do {
                completion(.success(try await data(from: request)))
            } catch {
                completion(.failure(error))
            }
        })
    }
    
    /// Makes network request and calls completion handler with a result of `JSON`or `Error`.
    public func json(
        from request: NetworkRequest,
        completion: @escaping ( Result<[String: Any?], Error>) -> Void
    ) {
        Task(operation: {
            do {
                completion(.success(try await json(from: request)))
            } catch {
                completion(.failure(error))
            }
        })
    }
    
    /// Makes network request and calls completion handler with a result of `JSON` `Array`or `Error`.
    public func jsonArray(
        from request: NetworkRequest,
        completion: @escaping (Result<[[String: Any?]], Error>) -> Void
    ) {
        Task(operation: {
            do {
                completion(.success(try await jsonArray(from: request)))
            } catch {
                completion(.failure(error))
            }
        })
    }
    
    /// Makes network request and calls completion handler with a result of `Decodable` or `Error`or `Error`.
    public func decodable<DecodableEntity: Decodable>(
        from request: NetworkRequest,
        completion: @escaping (Result<DecodableEntity, Error> ) -> Void
    ) {
        Task(operation: {
            do {
                completion(.success(try await decodable(from: request)))
            } catch {
                completion(.failure(error))
            }
        })
    }
    

    // MARK: Requests
    private func makeRequest<Entity>(
        request: NetworkRequest,
        decode: @escaping (Data) throws -> Entity
    ) async throws -> Entity {
        #if canImport(NetworkReachabilityService)
        guard NetworkReachabilityService.isConnectedToNetwork else { throw NetworkError.notConnectedToNetwork }
        #endif
        
        let urlRequest: URLRequest = try NetworkClientFactory.URLRequest.build(
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

            let processedResponse: URLResponse = try responseProcessor.response(data, response)
            guard processedResponse.isSuccessHTTPStatusCode else { throw NetworkError.invalidResponse }

            let processedData: Data = try responseProcessor.data(data, response)
            guard let entity: Entity = try? decode(processedData) else { throw NetworkError.invalidData }

            return entity

        } catch {
            try responseProcessor.error(error)
            throw error
        }
    }
    
    // This method solely exists for `noData` method
    private func makeRequest(
        request: NetworkRequest
    ) async throws {
        #if canImport(NetworkReachabilityService)
        guard NetworkReachabilityService.isConnectedToNetwork else { throw NetworkError.notConnectedToNetwork }
        #endif
        
        let urlRequest: URLRequest = try NetworkClientFactory.URLRequest.build(
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

            let processedResponse: URLResponse = try responseProcessor.response(data, response)
            guard processedResponse.isSuccessHTTPStatusCode else { throw NetworkError.invalidResponse }

        } catch {
            try responseProcessor.error(error)
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
                        continuation.resume(throwing: {
                            guard (error as NSError).domain == NSURLErrorDomain else { return NetworkError.returnedWithError }
                            
                            switch (error as NSError).code {
                            case NSURLErrorTimedOut: return NetworkError.requestTimedOut
                            case NSURLErrorNetworkConnectionLost: return NetworkError.notConnectedToNetwork
                            case NSURLErrorNotConnectedToInternet: return NetworkError.notConnectedToNetwork
                            default: return NetworkError.returnedWithError
                            }
                        }())
                        return
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
