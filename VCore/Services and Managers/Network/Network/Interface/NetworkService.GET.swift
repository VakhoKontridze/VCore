//
//  NetworkService.GET.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import UIKit

// MARK:- GET
extension NetworkService {
    /// Network object that performs GET network data tasks
    public struct GET {
        // MARK: Initializers
        private init() {}
    }
}

// MARK:- Data
extension NetworkService.GET {
    public static func data(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any],
        completion: @escaping (Result<Data, NetworkError>) -> Void
    ) {
        NetworkRequestService.get(
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
extension NetworkService.GET {
    public static func json(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any],
        completion: @escaping (Result<[String: Any], NetworkError>) -> Void
    ) {
        NetworkRequestService.get(
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { .success($0) },
            decode: { NetworkDecoderService.json(from: $0) }
        )
    }
    
    public static func json<Parameters: Encodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        completion: @escaping (Result<[String: Any], NetworkError>) -> Void
    ) {
        NetworkRequestService.get(
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
extension NetworkService.GET {
    public static func entity<Entity: Decodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any],
        entityType: Entity.Type,
        completion: @escaping (Result<Entity, NetworkError>) -> Void
    ) {
        NetworkRequestService.get(
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { .success($0) },
            decode: { NetworkDecoderService.entity(from: $0) }
        )
    }
    
    public static func entity<Parameters: Encodable, Entity: Decodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        entityType: Entity.Type,
        completion: @escaping (Result<Entity, NetworkError>) -> Void
    ) {
        NetworkRequestService.get(
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
extension NetworkService.GET {
    public static func image(
        endpoint: String,
        completion: @escaping (Result<UIImage, NetworkError>) -> Void
    ) {
        NetworkRequestService.get(
            endpoint: endpoint,
            headers: [:],
            parameters: [:],
            completion: completion,
            encode: { .success($0) },
            decode: { NetworkDecoderService.image(from: $0) }
        )
    }
}
