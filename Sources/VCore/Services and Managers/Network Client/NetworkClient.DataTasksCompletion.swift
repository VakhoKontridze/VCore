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
        completion: @escaping (ResultNoSuccess<any Error>) -> Void
    ) {
        makeRequest(
            request: request,
            decode: { _ in Void() },
            completion: { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success:
                    self.completionQueue.async(execute: { completion(.success) })
                    
                case .failure(let error): // Logged internally
                    self.completionQueue.async(execute: { completion(.failure(error)) })
                }
            }
        )
    }

    /// Makes network request and calls completion handler with a result of `Data`or `Error`.
    public func data(
        from request: NetworkRequest,
        completion: @escaping (Result<Data, any Error>) -> Void
    ) {
        makeRequest(
            request: request,
            decode: { $0 },
            completion: { [weak self] result in self?.completionQueue.async(execute: { completion(result) }) } // Logged internally
        )
    }

    /// Makes network request and calls completion handler with a result of `JSON`or `Error`.
    public func json(
        from request: NetworkRequest,
        decodingOptions: JSONSerialization.ReadingOptions = [],
        completion: @escaping ( Result<[String: Any?], any Error>) -> Void
    ) {
        makeRequest(
            request: request,
            decode: { try JSONDecoderService().json(data: $0, options: decodingOptions) },
            completion: { [weak self] result in self?.completionQueue.async(execute: { completion(result) }) } // Logged internally
        )
    }

    /// Makes network request and calls completion handler with a result of `JSON` `Array`or `Error`.
    public func jsonArray(
        from request: NetworkRequest,
        decodingOptions: JSONSerialization.ReadingOptions = [],
        completion: @escaping (Result<[[String: Any?]], any Error>) -> Void
    ) {
        makeRequest(
            request: request,
            decode: { try JSONDecoderService().jsonArray(data: $0, options: decodingOptions) },
            completion: { [weak self] result in self?.completionQueue.async(execute: { completion(result) }) } // Logged internally
        )
    }

    /// Makes network request and calls completion handler with a result of `Decodable` or `Error`.
    public func decodable<T>(
        _ type: T.Type,
        from request: NetworkRequest,
        completion: @escaping (Result<T, any Error>) -> Void
    )
        where T: Decodable
    {
        makeRequest(
            request: request,
            decode: { try JSONDecoderService().decodable(data: $0) },
            completion: { [weak self] result in self?.completionQueue.async(execute: { completion(result) }) } // Logged internally
        )
    }
    
    // MARK: Requests
    /*private*/ func makeRequest<Entity>(
        request: NetworkRequest,
        decode: @escaping (Data) throws -> Entity,
        completion: @escaping (Result<Entity, any Error>) -> Void
    ) {
        guard NetworkReachabilityService.shared.isConnectedToNetwork != false else {
            let error: NetworkClientError = .init(.notConnectedToNetwork)
            VCoreLogError(error)
            completion(.failure(error))
            return
        }
        
        let urlRequest: URLRequest
        do {
            urlRequest = try request.buildURLRequest()
            
        } catch {
            completion(.failure(error)) // Logged internally
            return
        }
        
        let task: URLSessionDataTask = URLSession(configuration: sessionConfiguration).dataTask(
            with: urlRequest,
            completionHandler: { (data, response, _error) in
                if let _error {
                    let error = {
                        guard (_error as NSError).domain == NSURLErrorDomain else { return NetworkClientError(.returnedWithError) }
                        
                        switch (_error as NSError).code {
                        case NSURLErrorNetworkConnectionLost: return NetworkClientError(.notConnectedToNetwork)
                        case NSURLErrorNotConnectedToInternet: return NetworkClientError(.notConnectedToNetwork)
                        case NSURLErrorCannotFindHost: return NetworkClientError(.invalidEndpoint)
                        case NSURLErrorBadURL: return NetworkClientError(.invalidEndpoint)
                        case NSURLErrorUnsupportedURL: return NetworkClientError(.invalidEndpoint)
                        case NSURLErrorTimedOut: return NetworkClientError(.requestTimedOut)
                        default: return NetworkClientError(.returnedWithError)
                        }
                    }()
                    VCoreLogError(error, _error)
                    completion(.failure(error))
                    return
                }
                
                guard let response else {
                    let error: NetworkClientError = .init(.invalidResponse)
                    VCoreLogError(error)
                    completion(.failure(error))
                    return
                }
                
                let processedResponse: URLResponse
                do {
                    if Entity.self != Void.self {
                        guard let data else {
                            let error: NetworkClientError = .init(.invalidData)
                            VCoreLogError(error)
                            completion(.failure(error))
                            return
                        }
                        
                        processedResponse = try self.responseProcessor.response(data, response)
                        
                    } else {
                        processedResponse = try self.responseProcessor.response(data ?? Data(), response)
                    }
                    
                } catch {
                    VCoreLogError(error)
                    completion(.failure(error))
                    return
                }
                
                guard processedResponse.isSuccessHTTPStatusCode else {
                    let error: NetworkClientError = .init(.invalidResponse)
                    VCoreLogError(error)
                    completion(.failure(error))
                    return
                }
                
                guard let data else {
                    let error: NetworkClientError = .init(.invalidData)
                    VCoreLogError(error)
                    completion(.failure(error))
                    return
                }
                
                if let entity = Void() as? Entity {
                    completion(.success(entity))
                    return
                }
                
                let processedData: Data
                do {
                    processedData = try self.responseProcessor.data(data, response)
                    
                } catch {
                    VCoreLogError(error)
                    completion(.failure(error))
                    return
                }
                
                let entity: Entity
                do {
                    entity = try decode(processedData)
                    
                } catch {
                    let error: NetworkClientError = .init(.invalidData)
                    VCoreLogError(error)
                    completion(.failure(error))
                    return
                }
                
                completion(.success(entity))
            }
        )
        
        task.resume()
    }
}
