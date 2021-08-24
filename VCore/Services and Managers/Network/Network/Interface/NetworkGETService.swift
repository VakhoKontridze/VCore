//
//  NetworkGETService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import UIKit

// MARK:- Network GET Service
/// Network service that performs GET network data tasks
public struct NetworkGETService {
    // MARK: Initializers
    init() {}
}

// MARK:- Data
extension NetworkGETService {
    /// Makes `GET` network request with `JSON` parameters and returns `Data` or `NetworkError`
    public func data(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any],
        completion: @escaping (Result<Data, NetworkError>) -> Void
    ) {
        NetworkRequestService().get(
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { .success($0) },
            decode: { .success($0) }
        )
    }
}

// MARK:- JSON
extension NetworkGETService {
    /// Makes `GET` network request with `JSON` parameters and returns `JSON` or `NetworkError`
    public func json(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any],
        completion: @escaping (Result<[String: Any], NetworkError>) -> Void
    ) {
        NetworkRequestService().get(
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { .success($0) },
            decode: { NetworkDecoderService.json(from: $0) }
        )
    }
    
    /// Makes `GET` network request with `Encodable` parameters and returns `JSON` or `NetworkError`
    public func json<Parameters: Encodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        completion: @escaping (Result<[String: Any], NetworkError>) -> Void
    ) {
        NetworkRequestService().get(
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { NetworkEncoderService.json(from: $0) },
            decode: { NetworkDecoderService.json(from: $0) }
        )
    }
}

// MARK:- Entity
extension NetworkGETService {
    /// Makes `GET` network request with `JSON` parameters and returns `Decodable` or `NetworkError`
    public func entity<Entity: Decodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any],
        entityType: Entity.Type,
        completion: @escaping (Result<Entity, NetworkError>) -> Void
    ) {
        NetworkRequestService().get(
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { .success($0) },
            decode: { NetworkDecoderService.entity(from: $0) }
        )
    }
    
    /// Makes `GET` network request with `Encodable` parameters and returns `Decodable` or `NetworkError`
    public func entity<Parameters: Encodable, Entity: Decodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        entityType: Entity.Type,
        completion: @escaping (Result<Entity, NetworkError>) -> Void
    ) {
        NetworkRequestService().get(
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { NetworkEncoderService.json(from: $0) },
            decode: { NetworkDecoderService.entity(from: $0) }
        )
    }
}

// MARK:- UIImage
extension NetworkGETService {
    /// Makes `GET` network request and returns `Data` or `NetworkError`
    public func image(
        endpoint: String,
        completion: @escaping (Result<UIImage, NetworkError>) -> Void
    ) {
        NetworkRequestService().get(
            endpoint: endpoint,
            headers: [:],
            parameters: [:],
            completion: completion,
            encode: { .success($0) },
            decode: { NetworkDecoderService.image(from: $0) }
        )
    }
}
