//
//  NetworkService.POST.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK:- POST
extension NetworkService {
    /// Network object that performs POST network data tasks
    public struct POST {
        // MARK: Initializers
        private init() {}
    }
}

// MARK:- Data
extension NetworkService.POST {
    /// Makes `POST` network request with `JSON` parameters and returns `Data` or `NetworkError`
    public static func json(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any],
        completion: @escaping (Result<Data, NetworkError>) -> Void)
    {
        NetworkRequestService.post(
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { NetworkEncoderService.json(from: $0) },
            decode: { .success($0) }
        )
    }
}

// MARK:- JSON
extension NetworkService.POST {
    /// Makes `POST` network request with `JSON` parameters and returns `JSON` or `NetworkError`
    public static func json(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any],
        completion: @escaping (Result<[String: Any], NetworkError>) -> Void)
    {
        NetworkRequestService.post(
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { NetworkEncoderService.json(from: $0) },
            decode: { NetworkDecoderService.json(from: $0) }
        )
    }

    /// Makes `POST` network request with `Encodable` parameters and returns `Data` or `NetworkError`
    public static func json<Parameters: Encodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        completion: @escaping (Result<[String: Any], NetworkError>) -> Void
    ) {
        NetworkRequestService.post(
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { NetworkEncoderService.entity(from: $0) },
            decode: { NetworkDecoderService.json(from: $0) }
        )
    }
}

// MARK:- Entity
extension NetworkService.POST {
    /// Makes `POST` network request with `JSON` parameters and returns `Decodable` or `NetworkError`
    public static func entity<Entity: Decodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any],
        entityType: Entity.Type,
        completion: @escaping (Result<Entity, NetworkError>) -> Void
    ) {
        NetworkRequestService.post(
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { NetworkEncoderService.json(from: $0) },
            decode: { NetworkDecoderService.entity(from: $0) }
        )
    }

    /// Makes `POST` network request with `Encodable` parameters and returns `Decodable` or `NetworkError`
    public static func entity<Parameters: Encodable, Entity: Decodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        entityType: Entity.Type,
        completion: @escaping (Result<Entity, NetworkError>) -> Void
    ) {
        NetworkRequestService.post(
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { NetworkEncoderService.entity(from: $0) },
            decode: { NetworkDecoderService.entity(from: $0) }
        )
    }
}
