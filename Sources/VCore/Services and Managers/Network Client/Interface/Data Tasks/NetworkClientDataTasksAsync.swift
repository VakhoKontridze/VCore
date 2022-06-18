//
//  NetworkClientDataTasksAsync.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.06.22.
//

import Foundation

// MARK: - Async Data Tasks
extension NetworkClient {
    // MARK: API
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
    public func decodable<T>(
        from request: NetworkRequest
    ) async throws -> T
        where T: Decodable
    {
        try await makeRequest(
            request: request,
            decode: { try JSONDecoderService.decodable(data: $0) }
        )
    }
    
    // MARK: Requests
    private func makeRequest<Entity>(
        request: NetworkRequest,
        decode: @escaping (Data) throws -> Entity
    ) async throws -> Entity {
        guard NetworkReachabilityService.shared.isConnectedToNetwork else { throw NetworkError.notConnectedToNetwork }
        
        let urlRequest: URLRequest = try NetworkClientFactory.URLRequest.build(from: request)

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
        guard NetworkReachabilityService.shared.isConnectedToNetwork else { throw NetworkError.notConnectedToNetwork }
        
        let urlRequest: URLRequest = try NetworkClientFactory.URLRequest.build(from: request)

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
}
