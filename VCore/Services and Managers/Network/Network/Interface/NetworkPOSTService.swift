//
//  NetworkPOSTService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - Network POST Service
/// Network service that performs POST network data tasks
public struct NetworkPOSTService {
    // MARK: Initializers
    init() {}
}

// MARK: - Data
extension NetworkPOSTService {
    /// Makes `POST` network request with `JSON` parameters and returns `Data` or `NetworkError`
    public func data(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any],
        completion: @escaping (Result<Data, NetworkError>) -> Void)
    {
        NetworkRequestService().POST(
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { JSONEncoderService.data(from: $0).asResultWithNetworkError },
            decode: { .success($0) }
        )
    }
}

// MARK: - JSON
extension NetworkPOSTService {
    /// Makes `POST` network request with `JSON` parameters and returns `JSON` or `NetworkError`
    public func json(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any],
        completion: @escaping (Result<[String: Any], NetworkError>) -> Void)
    {
        NetworkRequestService().POST(
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { JSONEncoderService.data(from: $0).asResultWithNetworkError },
            decode: { JSONDecoderService.json(from: $0).asResultWithNetworkError }
        )
    }

    /// Makes `POST` network request with `Encodable` parameters and returns `Data` or `NetworkError`
    public func json<Parameters: Encodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        completion: @escaping (Result<[String: Any], NetworkError>) -> Void
    ) {
        NetworkRequestService().POST(
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { JSONEncoderService.data(from: $0).asResultWithNetworkError },
            decode: { JSONDecoderService.json(from: $0).asResultWithNetworkError }
        )
    }
}

// MARK: - Entity
extension NetworkPOSTService {
    /// Makes `POST` network request with `JSON` parameters and returns `Decodable` or `NetworkError`
    public func entity<Entity: Decodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any],
        entityType: Entity.Type,
        completion: @escaping (Result<Entity, NetworkError>) -> Void
    ) {
        NetworkRequestService().POST(
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { JSONEncoderService.data(from: $0).asResultWithNetworkError },
            decode: { JSONDecoderService.entity(from: $0).asResultWithNetworkError }
        )
    }

    /// Makes `POST` network request with `Encodable` parameters and returns `Decodable` or `NetworkError`
    public func entity<Parameters: Encodable, Entity: Decodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        entityType: Entity.Type,
        completion: @escaping (Result<Entity, NetworkError>) -> Void
    ) {
        NetworkRequestService().POST(
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { JSONEncoderService.data(from: $0).asResultWithNetworkError },
            decode: { JSONDecoderService.entity(from: $0).asResultWithNetworkError }
        )
    }
}
