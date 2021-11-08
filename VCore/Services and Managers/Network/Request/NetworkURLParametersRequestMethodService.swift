//
//  NetworkURLParametersRequestMethodService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import Foundation

// MARK: - Network URL Parameters Request Method Service
/// Network service that performs network data tasks.
public class NetworkURLParametersRequestMethodService: NetworkRequestMethod {
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
    
    // MARK: Data
    /// Makes `network request with `Encodable` parameters and returns `Data` or `Error`.
    public func data<Parameters: Encodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        completion: @escaping (Result<Data, Error>) -> Void
    )  {
        networkRequestService.requestURLParameterMethodTask(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { JSONEncoderService.json(from: $0) },
            decode: { .success($0) }
        )
    }

    // MARK: JSON
    /// Makes `network request with `Encodable` parameters and returns `JSON` or `Error`.
    public func json<Parameters: Encodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        completion: @escaping (Result<[String: Any], Error>) -> Void
    ) {
        networkRequestService.requestURLParameterMethodTask(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { JSONEncoderService.json(from: $0) },
            decode: { JSONDecoderService.json(from: $0) }
        )
    }
    
    // MARK: JSON Array
    /// Makes `network request with `Encodable` parameters and returns `JSON Array` or `Error`.
    public func jsonArray<Parameters: Encodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        completion: @escaping (Result<[[String: Any]], Error>) -> Void
    ) {
        networkRequestService.requestURLParameterMethodTask(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { JSONEncoderService.json(from: $0) },
            decode: { JSONDecoderService.jsonArray(from: $0) }
        )
    }

    // MARK: Entity
    /// Makes network request with `Encodable` parameters and returns `Decodable` or `Error`.
    public func entity<Parameters: Encodable, Entity: Decodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        entityType: Entity.Type,
        completion: @escaping (Result<Entity, Error>) -> Void
    ) {
        networkRequestService.requestURLParameterMethodTask(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { JSONEncoderService.json(from: $0) },
            decode: { JSONDecoderService.entity(from: $0) }
        )
    }
}
