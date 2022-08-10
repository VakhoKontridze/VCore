//
//  NetworkClientDataTasksCompletion.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.06.22.
//

import Foundation

// MARK: - Completion Data Tasks
extension NetworkClient {
    // MARK: API
    /// Makes network calls completion handler with a result of success or `Error`.
    public func noData(
        from request: NetworkRequest,
        completion: @escaping (ResultNoSuccess<Error>) -> Void
    ) {
        makeRequest(
            request: request,
            completion: { [weak self] result in self?.completionQueue.async(execute: { completion(result) }) }
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
            completion: { [weak self] result in self?.completionQueue.async(execute: { completion(result) }) }
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
            completion: { [weak self] result in self?.completionQueue.async(execute: { completion(result) }) }
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
            completion: { [weak self] result in self?.completionQueue.async(execute: { completion(result) }) }
        )
    }

    /// Makes network request and calls completion handler with a result of `Decodable` or `Error`.
    public func decodable<T>(
        _ type: T.Type,
        from request: NetworkRequest,
        completion: @escaping (Result<T, Error>) -> Void
    )
        where T: Decodable
    {
        makeRequest(
            request: request,
            decode: { try JSONDecoderService.decodable(data: $0) },
            completion: { [weak self] result in self?.completionQueue.async(execute: { completion(result) }) }
        )
    }
    
    // MARK: Requests
    private func makeRequest<Entity>(
        request: NetworkRequest,
        decode: @escaping (Data) throws -> Entity,
        completion: @escaping (Result<Entity, Error>) -> Void
    ) {
        guard NetworkReachabilityService.shared.isConnectedToNetwork else {
            completion(.failure(NetworkClientError.notConnectedToNetwork))
            return
        }

        do {
            let urlRequest: URLRequest = try NetworkClientFactory.URLRequest.build(from: request)
            
            dataTask(request: urlRequest, completion: { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success((let data, let response)):
                    do {
                        let processedResponse: URLResponse = try self.responseProcessor.response(data, response)
                        guard processedResponse.isSuccessHTTPStatusCode else {
                            completion(.failure(NetworkClientError.invalidResponse))
                            return
                        }
                        
                        let processedData: Data = try self.responseProcessor.data(data, response)
                        guard let entity: Entity = try? decode(processedData) else {
                            completion(.failure(NetworkClientError.invalidData))
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
        guard NetworkReachabilityService.shared.isConnectedToNetwork else {
            completion(.failure(NetworkClientError.notConnectedToNetwork))
            return
        }

        do {
            let urlRequest: URLRequest = try NetworkClientFactory.URLRequest.build(from: request)
            
            dataTask(request: urlRequest, completion: { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success((let data, let response)):
                    do {
                        let processedResponse: URLResponse = try self.responseProcessor.response(data, response)
                        guard processedResponse.isSuccessHTTPStatusCode else {
                            completion(.failure(NetworkClientError.invalidResponse))
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
    
    /*private*/ func dataTask(
        request: URLRequest,
        completion: @escaping (Result<(Data, URLResponse), Error>) -> Void
    ) {
        let task: URLSessionDataTask = URLSession(configuration: sessionConfiguration).dataTask(
            with: request,
            completionHandler: { (data, response, error) in
                if let error {
                    completion(.failure({
                        guard (error as NSError).domain == NSURLErrorDomain else { return NetworkClientError.returnedWithError }
                        
                        switch (error as NSError).code {
                        case NSURLErrorNetworkConnectionLost: return NetworkClientError.notConnectedToNetwork
                        case NSURLErrorNotConnectedToInternet: return NetworkClientError.notConnectedToNetwork
                        case NSURLErrorCannotFindHost: return NetworkClientError.invalidEndpoint
                        case NSURLErrorBadURL: return NetworkClientError.invalidEndpoint
                        case NSURLErrorUnsupportedURL: return NetworkClientError.invalidEndpoint
                        case NSURLErrorTimedOut: return NetworkClientError.requestTimedOut
                        default: return NetworkClientError.returnedWithError
                        }
                    }()))
                    return
                }
                
                guard let response else {
                    completion(.failure(NetworkClientError.invalidResponse))
                    return
                }
                
                guard let data else {
                    completion(.failure(NetworkClientError.invalidData))
                    return
                }
                
                completion(.success((data, response)))
            }
        )
        
        task.resume()
    }
}
