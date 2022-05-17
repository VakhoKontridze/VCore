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
/// Usage Example:
///
///     func fetchData() async {
///         do {
///             var request: NetworkRequest = .init(url: "https://httpbin.org/post")
///             request.method = .POST
///             try request.addHeaders(encodable: JSONRequestHeaders())
///             try request.addBody(json: ["key": "value"])
///
///             let result: [String: Any?] = try await NetworkClient.default.json(from: request)
///
///             print(result["json"]?.toUnwrappedJSON["key"]?.toString ?? "-")
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
///             guard let json: [String: Any?] = try? JSONDecoderService.json(data: data) else { return response }
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
///                 let json: [String: Any?] = try? JSONDecoderService.json(data: data),
///                 let dataJSON: [String: Any?] = json["data"]?.toJSON,
///                 let dataData: Data = try? JSONEncoderService.data(encodable: dataJSON)
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
    
    /// Queue on which completion is returned. Defaults to `main`.
    public var completionQeueue: DispatchQueue = .main
    
    private let responseProcessor: NetworkResponseProcessor
    
    // MARK: Initializers
    /// Initializes `NetworkClient`.
    public init(responseProcessor: NetworkResponseProcessor) {
        self.responseProcessor = responseProcessor
        
        #if !os(watchOS)
        NetworkReachabilityService.configure()
        #endif
    }
    
    // MARK: Data Tasks (Async)
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
            decode: { try JSONDecoderService.json(data: $0) }
        )
    }
    
    /// Makes network request and returns `JSON` `Array`.
    public func jsonArray(
        from request: NetworkRequest
    ) async throws -> [[String: Any?]] {
        try await makeRequest(
            request: request,
            decode: { try JSONDecoderService.jsonArray(data: $0) }
        )
    }
    
    /// Makes network request and returns `Decodable`.
    public func decodable<T: Decodable>(
        from request: NetworkRequest
    ) async throws -> T {
        try await makeRequest(
            request: request,
            decode: { try JSONDecoderService.decodable(data: $0) }
        )
    }
    
    private func makeRequest<Entity>(
        request: NetworkRequest,
        decode: @escaping (Data) throws -> Entity
    ) async throws -> Entity {
        #if !os(watchOS)
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
            let (data, response): (Data, URLResponse) = try await data(request: urlRequest)

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
        #if !os(watchOS)
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
            let (data, response): (Data, URLResponse) = try await data(request: urlRequest)

            let processedResponse: URLResponse = try responseProcessor.response(data, response)
            guard processedResponse.isSuccessHTTPStatusCode else { throw NetworkError.invalidResponse }

        } catch {
            try responseProcessor.error(error)
            throw error
        }
    }
    
    private func data(
        request: URLRequest
    ) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation({ continuation in
            dataTask(request: request, completion: { result in
                switch result {
                case .success((let data, let response)): continuation.resume(returning: (data, response))
                case .failure(let error): continuation.resume(throwing: error)
                }
            })
        })
    }
    
    // MARK: Data Tasks (Completion)
    /// Makes network calls completion handler with a result of success or `Error`.
    public func noData(
        from request: NetworkRequest,
        completion: @escaping (ResultNoSuccess<Error>) -> Void
    ) {
        makeRequest(
            request: request,
            completion: { [weak self] result in self?.completionQeueue.async(execute: { completion(result) }) }
        )
    }

    /// Makes network request and calls completion handler with a result of `Data`or `Error`.
    public func data(
        from request: NetworkRequest,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        makeRequest(
            request: request,
            decode: { $0 },
            completion: { [weak self] result in self?.completionQeueue.async(execute: { completion(result) }) }
        )
    }

    /// Makes network request and calls completion handler with a result of `JSON`or `Error`.
    public func json(
        from request: NetworkRequest,
        completion: @escaping ( Result<[String: Any?], Error>) -> Void
    ) {
        makeRequest(
            request: request,
            decode: { try JSONDecoderService.json(data: $0) },
            completion: { [weak self] result in self?.completionQeueue.async(execute: { completion(result) }) }
        )
    }

    /// Makes network request and calls completion handler with a result of `JSON` `Array`or `Error`.
    public func jsonArray(
        from request: NetworkRequest,
        completion: @escaping (Result<[[String: Any?]], Error>) -> Void
    ) {
        makeRequest(
            request: request,
            decode: { try JSONDecoderService.jsonArray(data: $0) },
            completion: { [weak self] result in self?.completionQeueue.async(execute: { completion(result) }) }
        )
    }

    /// Makes network request and calls completion handler with a result of `Decodable` or `Error`.
    public func decodable<T: Decodable>(
        _ type: T.Type,
        from request: NetworkRequest,
        completion: @escaping (Result<T, Error> ) -> Void
    ) {
        makeRequest(
            request: request,
            decode: { try JSONDecoderService.decodable(data: $0) },
            completion: { [weak self] result in self?.completionQeueue.async(execute: { completion(result) }) }
        )
    }
    
    private func makeRequest<Entity>(
        request: NetworkRequest,
        decode: @escaping (Data) throws -> Entity,
        completion: @escaping (Result<Entity, Error>) -> Void
    ) {
        #if !os(watchOS)
        guard NetworkReachabilityService.isConnectedToNetwork else {
            completion(.failure(NetworkError.notConnectedToNetwork))
            return
        }
        #endif

        do {
            let urlRequest: URLRequest = try NetworkClientFactory.URLRequest.build(
                endpoint: request.url,
                method: request.method.httpMethod,
                pathParameters: request.pathParameters,
                headers: request.headers,
                queryParameters: request.queryParameters,
                body: request.body.nonEmpty
            )
            
            dataTask(request: urlRequest, completion: { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success((let data, let response)):
                    do {
                        let processedResponse: URLResponse = try self.responseProcessor.response(data, response)
                        guard processedResponse.isSuccessHTTPStatusCode else {
                            completion(.failure(NetworkError.invalidResponse))
                            return
                        }
                        
                        let processedData: Data = try self.responseProcessor.data(data, response)
                        guard let entity: Entity = try? decode(processedData) else {
                            completion(.failure(NetworkError.invalidData))
                            return
                        }
                        
                        completion(.success(entity))
                    
                    } catch {
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    do {
                        try self.responseProcessor.error(error)
                        completion(.failure(error))
                        
                    } catch {
                        completion(.failure(error))
                    }
                }
            })

        } catch {
            completion(.failure(error))
        }
    }
    
    // This method solely exists for `noData` method
    private func makeRequest(
        request: NetworkRequest,
        completion: @escaping (ResultNoSuccess<Error>) -> Void
    ) {
        #if !os(watchOS)
        guard NetworkReachabilityService.isConnectedToNetwork else {
            completion(.failure(NetworkError.notConnectedToNetwork))
            return
        }
        #endif

        do {
            let urlRequest: URLRequest = try NetworkClientFactory.URLRequest.build(
                endpoint: request.url,
                method: request.method.httpMethod,
                pathParameters: request.pathParameters,
                headers: request.headers,
                queryParameters: request.queryParameters,
                body: request.body.nonEmpty
            )
            
            dataTask(request: urlRequest, completion: { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success((let data, let response)):
                    do {
                        let processedResponse: URLResponse = try self.responseProcessor.response(data, response)
                        guard processedResponse.isSuccessHTTPStatusCode else {
                            completion(.failure(NetworkError.invalidResponse))
                            return
                        }
                        
                        completion(.success)
                    
                    } catch {
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    do {
                        try self.responseProcessor.error(error)
                        completion(.failure(error))
                        
                    } catch {
                        completion(.failure(error))
                    }
                }
            })

        } catch {
            completion(.failure(error))
        }
    }
    
    private func dataTask(
        request: URLRequest,
        completion: @escaping (Result<(Data, URLResponse), Error>) -> Void
    ) {
        let task: URLSessionDataTask = URLSession(configuration: sessionConfiguration).dataTask(
            with: request,
            completionHandler: { (data, response, error) in
                if let error = error {
                    completion(.failure({
                        guard (error as NSError).domain == NSURLErrorDomain else { return NetworkError.returnedWithError }
                        
                        switch (error as NSError).code {
                        case NSURLErrorNetworkConnectionLost: return NetworkError.notConnectedToNetwork
                        case NSURLErrorNotConnectedToInternet: return NetworkError.notConnectedToNetwork
                        case NSURLErrorCannotFindHost: return NetworkError.invalidEndpoint
                        case NSURLErrorBadURL: return NetworkError.invalidEndpoint
                        case NSURLErrorUnsupportedURL: return NetworkError.invalidEndpoint
                        case NSURLErrorTimedOut: return NetworkError.requestTimedOut
                        default: return NetworkError.returnedWithError
                        }
                    }()))
                    return
                }
                
                guard let response = response else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                
                completion(.success((data, response)))
            }
        )
        
        task.resume()
    }
}

// MARK: - Helpers
extension Data {
    fileprivate var nonEmpty: Data? {
        guard count != 0 else { return nil }
        return self
    }
}
