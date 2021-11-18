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
    private let processor: NetworkServiceProcessor
    
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
        processor: NetworkServiceProcessor
    ) {
        self.networkService = networkService
        self.processor = processor
    }

    // MARK: Request
    func request<Parameters, EncodedParameters, Entity>(
        httpMethod: String,
        headers: [String: Any?],
        parameters: Parameters,
        encode: @escaping (Parameters) throws -> EncodedParameters,
        decode: @escaping (Data) throws -> Entity,
        request: (EncodedParameters) throws -> URLRequest
    ) async throws -> Entity {
        guard NetworkReachabilityService.isConnectedToNetwork else { throw NetworkError.notConnectedToNetwork }

        guard let encodedParameters: EncodedParameters = try? encode(parameters) else { throw NetworkError.incompleteParameters }
        let request: URLRequest = try request(encodedParameters)
        
        do {
            let (data, response): (Data, URLResponse) = try await data(for: request)
            
            let processedResponse: URLResponse = try processor.response(data, response)
            guard processedResponse.isValid else { throw NetworkError.invalidResponse }
            
            let processedData: Data = try processor.data(data, response)
            guard let entity: Entity = try? decode(processedData) else { throw NetworkError.incompleteData }
            
            return entity
        
        } catch let error {
            try processor.error(error)
            throw error
        }
    }
    
    // func data(for request: URLRequest, delegate: URLSessionTaskDelegate? = nil) async throws -> (Data, URLResponse)
    private func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation({ continuation in
            let task: URLSessionDataTask = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
                if let error = error {
                    if (error as NSError).domain == "NSURLErrorDomain" && (error as NSError).code == -1001 {
                        continuation.resume(throwing: NetworkError.requestTimeOut)
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
                    continuation.resume(throwing: NetworkError.incompleteData)
                    return
                }
                
                continuation.resume(returning: (data, response))
            })
            
            task.resume()
        })
    }
}

// MARK: - Helpers - Response
extension URLResponse {
    /// Checks that response is valid.
    public var isValid: Bool {
        guard
            let httpResponse: HTTPURLResponse = self as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            return false
        }

        return true
    }
}

// MARK: - Helpers - URL
extension URL {
    init(
        endpoint: String,
        encodedParameters: [String: Any?]
    ) throws {
        guard var urlComponents: URLComponents = .init(string: endpoint) else { throw NetworkError.invalidEndpoint }
        urlComponents.addItems(encodedParameters)
        
        guard let url: URL = urlComponents.url else { throw NetworkError.incompleteParameters }
        self = url
    }
}

extension URLComponents {
    fileprivate mutating func addItems(_ items: [String: Any?]) {
        guard !items.isEmpty else { return }
        
        switch queryItems {
        case nil: queryItems = items.compactMap { .init($0) }
        case _?: items.compactMap { URLQueryItem($0) }.forEach { queryItems?.append($0) }
        }
    }
}

extension URLQueryItem {
    fileprivate init?(_ item: Dictionary<String, Any?>.Element) {
        guard
            let value = item.value,
            let strValue: String = .init(safelyDescribing: value)
        else {
            return nil
        }
        
        self.init(name: item.key, value: strValue)
    }
}

// MARK: - Helpers - URL Request
extension URLRequest {
    init(
        httpMethod: String,
        url: URL,
        headers: [String: Any?],
        body: Data?
    ) {
        self.init(url: url)
        self.httpMethod = httpMethod
        self.addHTTPHeaders(headers)
        self.httpBody = body
    }
    
    private mutating func addHTTPHeaders(_ items: [String: Any?]) {
        guard !items.isEmpty else { return }
        
        items.forEach { (key, value) in
            guard
                let value = value,
                let strValue: String = .init(safelyDescribing: value)
            else {
                return
            }
            
            addValue(strValue, forHTTPHeaderField: key)
        }
    }
}
