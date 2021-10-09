//
//  NetworkRequestService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - Network Request Service
final class NetworkRequestService {
    // MARK: Properties
    private unowned let networkService: NetworkService
    private let postProcessor: NetworkServicePostProcessor
    
    private var urlSession: URLSession {
        .init(configuration: {
            let configuration: URLSessionConfiguration = .default
            configuration.timeoutIntervalForRequest = networkService.timeoutIntervalForRequest
            configuration.timeoutIntervalForResource = networkService.timeoutIntervalForResource
            return configuration
        }())
    }
    
    // MARK: Initializers
    init(
        networkService: NetworkService,
        postProcessor: NetworkServicePostProcessor
    ) {
        self.networkService = networkService
        self.postProcessor = postProcessor
    }

    // MARK: Requests
    func requestURLParameterMethodTask<Parameters, Entity>(
        httpMethod: String,
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        completion: @escaping (Result<Entity, NetworkError>) -> Void,
        encode: @escaping (Parameters) -> Result<[String: Any], NetworkError>,
        decode: @escaping (Data) -> Result<Entity, NetworkError>
    ) {
        requestTask(
            httpMethod: httpMethod,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: encode,
            decode: decode,
            createRequest: { encodedParameters in
                guard var urlComponents: URLComponents = .init(string: endpoint) else {
                    return .failure(.invalidEndpoint)
                }
                
                urlComponents.addItems(encodedParameters)
                
                guard let url: URL = urlComponents.url else {
                    return .failure(.incompleteParameters(.init(
                        domain: nil,
                        code: nil,
                        description: nil
                    )))
                }
                
                let request: URLRequest = .init(
                    httpMethod: httpMethod,
                    url: url,
                    headers: headers,
                    body: nil
                )
                
                return .success(request)
            }
        )
    }

    func requestBodyParameterMethodTask<Parameters, Entity>(
        httpMethod: String,
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        completion: @escaping (Result<Entity, NetworkError>) -> Void,
        encode: @escaping (Parameters) -> Result<Data, NetworkError>,
        decode: @escaping (Data) -> Result<Entity, NetworkError>
    ) {
        requestTask(
            httpMethod: httpMethod,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: encode,
            decode: decode,
            createRequest: { encodedParameters in
                guard let url: URL = .init(string: endpoint) else {
                    return .failure(.invalidEndpoint)
                }
                
                let request: URLRequest = .init(
                    httpMethod: httpMethod,
                    url: url,
                    headers: headers,
                    body: encodedParameters
                )
                
                return .success(request)
            }
        )
    }
    
    private func requestTask<Parameters, EncodedParameters, Entity>(
        httpMethod: String,
        headers: [String: Any],
        parameters: Parameters,
        completion: @escaping (Result<Entity, NetworkError>) -> Void,
        encode: @escaping (Parameters) -> Result<EncodedParameters, NetworkError>,
        decode: @escaping (Data) -> Result<Entity, NetworkError>,
        createRequest: (EncodedParameters) -> Result<URLRequest, NetworkError>
    ) {
        guard NetworkReachabilityService.isConnectedToNetwork else {
            networkService.queue.async(completion(.failure(.notConnectedToNetwork)))
            return
        }

        switch encode(parameters) {
        case .success(let encodedParameters):
            switch createRequest(encodedParameters) {
            case .success(let request):
                let task: URLSessionDataTask = urlSession.dataTask(
                    with: request,
                    completionHandler: { [weak self] (data, response, error) in
                        self?.process(
                            data: data,
                            response: response,
                            error: error,
                            completion: completion,
                            decode: decode
                        )
                    }
                )
                
                task.resume()
                
            case .failure(let error):
                networkService.queue.async(completion(.failure(error)))
            }
            
        case .failure(let encodingError):
            networkService.queue.async(completion(.failure(.incompleteParameters(.init(
                domain: encodingError.domain,
                code: encodingError.code,
                description: encodingError.localizedDescription
            )))))
        }
    }
    
    private func process<Entity>(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        completion: @escaping (Result<Entity, NetworkError>) -> Void,
        decode: @escaping (Data) -> Result<Entity, NetworkError>
    ) {
        if let error = error {
            networkService.queue.async(completion(.failure(.returnedWithError(.init(
                domain: (error as NSError).domain,
                code: (error as NSError).code,
                description: error.localizedDescription
            )))))
        
        } else if let response = response, !response.isValid {
            networkService.queue.async(completion(.failure(.invalidResponse(.init(
                domain: nil,
                code: (response as? HTTPURLResponse)?.statusCode,
                description: response.description
            )))))
        
        } else if let data = data {
            switch postProcessor.postProcess(data) {
            case .success(let postProcessedData):
                switch decode(postProcessedData) {
                case .success(let decodedData):
                    networkService.queue.async(completion(.success(decodedData)))

                case .failure(let decodingError):
                    networkService.queue.async(completion(.failure(.incompleteEntity(.init(
                        domain: decodingError.domain,
                        code: decodingError.code,
                        description: decodingError.localizedDescription
                    )))))
                }

            case .failure(let error):
                networkService.queue.async(completion(.failure(error)))
            }
        
        } else {
            networkService.queue.async(completion(.failure(.incompleteEntity(.init(
                domain: nil,
                code: nil,
                description: nil
            )))))
        }
    }
}

// MARK: - Helpers - Response
extension URLResponse {
    fileprivate var isValid: Bool {
        guard
            let httpResponse: HTTPURLResponse = self as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            return false
        }

        return true
    }
}

// MARK: - Helpers - Query Parameters
extension URLComponents {
    fileprivate mutating func addItems(_ items: [String: Any]) {
        guard !items.isEmpty else { return }
        
        switch queryItems {
        case nil: queryItems = items.map { .init($0) }
        case _?: items.forEach { queryItems?.append(.init($0)) }
        }
    }
}

extension URLQueryItem {
    fileprivate init(_ item: Dictionary<String, Any>.Element) {
        self.init(name: item.key, value: .init(describing: item.value))
    }
}

// MARK: - Helpers - URL Request
extension URLRequest {
    fileprivate init(
        httpMethod: String,
        url: URL,
        headers: [String: Any],
        body: Data?
    ) {
        self.init(url: url)
        self.httpMethod = httpMethod
        self.addHTTPHeaders(headers)
        self.httpBody = body
    }
    
    private mutating func addHTTPHeaders(_ items: [String: Any]) {
        guard !items.isEmpty else { return }
        
        items.forEach { (key, value) in
            addValue(.init(describing: value), forHTTPHeaderField: key)
        }
    }
}

// MARK: - Helpers - Async
extension DispatchQueue {
    fileprivate func async(_ block: @autoclosure @escaping () -> Void) {
        async(execute: block)
    }
}
