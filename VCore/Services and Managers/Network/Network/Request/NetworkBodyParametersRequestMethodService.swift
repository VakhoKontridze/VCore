//
//  NetworkBodyParametersRequestMethodService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import Foundation

// MARK: - Network Body Parameters Request Method Service
/// Network service that performs network data tasks.
public class NetworkBodyParametersRequestMethodService: NetworkRequestMethod {
    // MARK: Properties
    private let networkRequestService: NetworkRequestService
    
    /// HTTP request method.
    public let httpMethod: String
    
    // MARK: Initializers
    init(
        networkRequestService: NetworkRequestService,
        httpMethod: String
    ) {
        self.networkRequestService = networkRequestService
        self.httpMethod = httpMethod
    }
    
    // MARK: Request
    private func request<Parameters, Entity>(
        httpMethod: String,
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        encode: @escaping (Parameters) throws -> Data,
        decode: @escaping (Data) throws -> Entity
    ) async throws -> Entity {
        try await networkRequestService.request(
            httpMethod: httpMethod,
            headers: headers,
            parameters: parameters,
            encode: encode,
            decode: decode,
            request: { encodedParameters in
                guard let url: URL = .init(string: endpoint) else { throw NetworkError.invalidEndpoint }

                return .init(
                    httpMethod: httpMethod,
                    url: url,
                    headers: headers,
                    body: encodedParameters
                )
            }
        )
    }
    
    // MARK: Data
    /// Makes network request with `Data` parameters and returns `Data` or `Error`.
    public func data(
        endpoint: String,
        headers: [String: Any],
        parameters: Data
    ) async throws -> Data {
        try await request(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            encode: { $0 },
            decode: { $0 }
        )
    }
    
    /// Makes network request with `JSON` parameters and returns `Data` or `Error`.
    public func data(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any]
    ) async throws -> Data {
        try await request(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            encode: { try JSONEncoderService.data(from: $0) },
            decode: { $0 }
        )
    }
    
    /// Makes network request with `Encodable` parameters and returns `Data` or `Error`.
    public func data<Parameters: Encodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters
    ) async throws -> Data {
        try await request(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            encode: { try JSONEncoderService.data(from: $0) },
            decode: { $0 }
        )
    }

    // MARK: JSON
    /// Makes network request with `Data` parameters and returns `JSON` or `Error`.
    public func json(
        endpoint: String,
        headers: [String: Any],
        parameters: Data
    ) async throws -> [String: Any] {
        try await request(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            encode: { $0 },
            decode: { try JSONDecoderService.json(from: $0) }
        )
    }
    
    /// Makes network request with `JSON` parameters and returns `JSON` or `Error`.
    public func json(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any]
    ) async throws -> [String: Any] {
        try await request(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            encode: { try JSONEncoderService.data(from: $0) },
            decode: { try JSONDecoderService.json(from: $0) }
        )
    }

    /// Makes network request with `Encodable` parameters and returns `Data` or `Error`.
    public func json<Parameters: Encodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters
    ) async throws -> [String: Any] {
        try await request(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            encode: { try JSONEncoderService.data(from: $0) },
            decode: { try JSONDecoderService.json(from: $0) }
        )
    }
    
    // MARK: JSON Array
    /// Makes network request with `Data` parameters and returns `JSON` or `Error`.
    public func jsonArray(
        endpoint: String,
        headers: [String: Any],
        parameters: Data
    ) async throws -> [[String: Any]] {
        try await request(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            encode: { $0 },
            decode: { try JSONDecoderService.jsonArray(from: $0) }
        )
    }
    
    /// Makes network request with `JSON` parameters and returns `JSON` or `Error`.
    public func jsonArray(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any]
    ) async throws -> [[String: Any]] {
        try await request(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            encode: { try JSONEncoderService.data(from: $0) },
            decode: { try JSONDecoderService.jsonArray(from: $0) }
        )
    }

    /// Makes network request with `Encodable` parameters and returns `Data` or `Error`.
    public func jsonArray<Parameters: Encodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters
    ) async throws -> [[String: Any]] {
        try await request(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            encode: { try JSONEncoderService.data(from: $0) },
            decode: { try JSONDecoderService.jsonArray(from: $0) }
        )
    }

    // MARK: Entity
    /// Makes network request with `Data` parameters and returns `Decodable` or `Error`.
    public func entity<Entity: Decodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Data
    ) async throws -> Entity {
        try await request(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            encode: { $0 },
            decode: { try JSONDecoderService.entity(from: $0) }
        )
    }
    
    /// Makes network request with `JSON` parameters and returns `Decodable` or `Error`.
    public func entity<Entity: Decodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any]
    ) async throws -> Entity {
        try await request(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            encode: { try JSONEncoderService.data(from: $0) },
            decode: { try JSONDecoderService.entity(from: $0) }
        )
    }

    /// Makes network request with `Encodable` parameters and returns `Decodable` or `Error`.
    public func entity<Parameters: Encodable, Entity: Decodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters
    ) async throws -> Entity {
        try await request(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            encode: { try JSONEncoderService.data(from: $0) },
            decode: { try JSONDecoderService.entity(from: $0) }
        )
    }
}
