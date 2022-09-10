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
        try await makeRequest( // Logged internally
            request: request,
            decode: { _ in Void() }
        )
    }
    
    /// Makes network request and returns `Data`.
    public func data(
        from request: NetworkRequest
    ) async throws -> Data {
        try await makeRequest( // Logged internally
            request: request,
            decode: { $0 }
        )
    }
    
    /// Makes network request and returns `JSON`.
    public func json(
        from request: NetworkRequest
    ) async throws -> [String: Any?] {
        try await makeRequest( // Logged internally
            request: request,
            decode: { try JSONDecoderService().json(data: $0) }
        )
    }
    
    /// Makes network request and returns `JSON` `Array`.
    public func jsonArray(
        from request: NetworkRequest
    ) async throws -> [[String: Any?]] {
        try await makeRequest( // Logged internally
            request: request,
            decode: { try JSONDecoderService().jsonArray(data: $0) }
        )
    }
    
    /// Makes network request and returns `Decodable`.
    public func decodable<T>(
        from request: NetworkRequest
    ) async throws -> T
        where T: Decodable
    {
        try await makeRequest( // Logged internally
            request: request,
            decode: { try JSONDecoderService().decodable(data: $0) }
        )
    }
    
    // MARK: Requests
    private func makeRequest<Entity>(
        request: NetworkRequest,
        decode: @escaping (Data) throws -> Entity
    ) async throws -> Entity {
        try await withCheckedThrowingContinuation({ continuation in
            makeRequest(
                request: request,
                decode: decode,
                completion: { result in
                    switch result {
                    case .success(let data): continuation.resume(returning: data)
                    case .failure(let error): continuation.resume(throwing: error)
                    }
                }
            )
        })
    }
}
