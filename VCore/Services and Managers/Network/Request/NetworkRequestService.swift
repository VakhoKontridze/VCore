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
        headers: [String: Any],
        parameters: Parameters,
        encode: @escaping (Parameters) throws -> EncodedParameters,
        decode: @escaping (Data) throws -> Entity,
        request: (EncodedParameters) throws -> URLRequest
    ) async throws -> Entity {
        guard NetworkReachabilityService.isConnectedToNetwork else { throw NetworkError.notConnectedToNetwork }

        guard let encodedParameters: EncodedParameters = try? encode(parameters) else { throw NetworkError.incompleteParameters }
        let request: URLRequest = try request(encodedParameters)
        
        do {
            let (data, response): (Data, URLResponse) = try await urlSession.data(for: request, delegate: nil)
            
            let processedResponse: URLResponse = try processor.response(data, response)
            guard processedResponse.isValid else { throw NetworkError.invalidResponse }
            
            let processedData: Data = try processor.data(data, response)
            guard let entity: Entity = try? decode(processedData) else { throw NetworkError.incompleteEntity }
            
            return entity
        
        } catch let error {
            try processor.error(error)
            throw NetworkError.returnedWithError
        }
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
        encodedParameters: [String: Any]
    ) throws {
        guard var urlComponents: URLComponents = .init(string: endpoint) else { throw NetworkError.invalidEndpoint }
        urlComponents.addItems(encodedParameters)
        
        guard let url: URL = urlComponents.url else { throw NetworkError.incompleteParameters }
        self = url
    }
}

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
    init(
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
