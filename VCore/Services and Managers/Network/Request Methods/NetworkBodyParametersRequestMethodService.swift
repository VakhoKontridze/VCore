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
    
    // MARK: Data
    /// Makes network request with `Data` parameters and returns `Data` or `Error`.
    public func data(
        endpoint: String,
        headers: [String: Any],
        parameters: Data,
        completion: @escaping (Result<Data, Error>) -> Void)
    {
        networkRequestService.requestBodyParameterMethodTask(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { .success($0) },
            decode: { .success($0) }
        )
    }
    
    /// Makes network request with `JSON` parameters and returns `Data` or `Error`.
    public func data(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any],
        completion: @escaping (Result<Data, Error>) -> Void)
    {
        networkRequestService.requestBodyParameterMethodTask(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { JSONEncoderService.data(from: $0) },
            decode: { .success($0) }
        )
    }
    
    /// Makes network request with `Encodable` parameters and returns `Data` or `Error`.
    public func data<Parameters: Encodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        completion: @escaping (Result<Data, Error>) -> Void
    )  {
        networkRequestService.requestBodyParameterMethodTask(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { JSONEncoderService.data(from: $0) },
            decode: { .success($0) }
        )
    }

    // MARK: JSON
    /// Makes network request with `Data` parameters and returns `JSON` or `Error`.
    public func json(
        endpoint: String,
        headers: [String: Any],
        parameters: Data,
        completion: @escaping (Result<[String: Any], Error>) -> Void)
    {
        networkRequestService.requestBodyParameterMethodTask(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { .success($0) },
            decode: { JSONDecoderService.json(from: $0) }
        )
    }
    
    /// Makes network request with `JSON` parameters and returns `JSON` or `Error`.
    public func json(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any],
        completion: @escaping (Result<[String: Any], Error>) -> Void)
    {
        networkRequestService.requestBodyParameterMethodTask(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { JSONEncoderService.data(from: $0) },
            decode: { JSONDecoderService.json(from: $0) }
        )
    }

    /// Makes network request with `Encodable` parameters and returns `Data` or `Error`.
    public func json<Parameters: Encodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        completion: @escaping (Result<[String: Any], Error>) -> Void
    ) {
        networkRequestService.requestBodyParameterMethodTask(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { JSONEncoderService.data(from: $0) },
            decode: { JSONDecoderService.json(from: $0) }
        )
    }
    
    // MARK: JSON Array
    /// Makes network request with `Data` parameters and returns `JSON` or `Error`.
    public func jsonArray(
        endpoint: String,
        headers: [String: Any],
        parameters: Data,
        completion: @escaping (Result<[[String: Any]], Error>) -> Void)
    {
        networkRequestService.requestBodyParameterMethodTask(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { .success($0) },
            decode: { JSONDecoderService.jsonArray(from: $0) }
        )
    }
    
    /// Makes network request with `JSON` parameters and returns `JSON` or `Error`.
    public func jsonArray(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any],
        completion: @escaping (Result<[[String: Any]], Error>) -> Void)
    {
        networkRequestService.requestBodyParameterMethodTask(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { JSONEncoderService.data(from: $0) },
            decode: { JSONDecoderService.jsonArray(from: $0) }
        )
    }

    /// Makes network request with `Encodable` parameters and returns `Data` or `Error`.
    public func jsonArray<Parameters: Encodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        completion: @escaping (Result<[[String: Any]], Error>) -> Void
    ) {
        networkRequestService.requestBodyParameterMethodTask(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { JSONEncoderService.data(from: $0) },
            decode: { JSONDecoderService.jsonArray(from: $0) }
        )
    }

    // MARK: Entity
    /// Makes network request with `Data` parameters and returns `Decodable` or `Error`.
    public func entity<Entity: Decodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Data,
        entityType: Entity.Type,
        completion: @escaping (Result<Entity, Error>) -> Void
    ) {
        networkRequestService.requestBodyParameterMethodTask(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { .success($0) },
            decode: { JSONDecoderService.entity(from: $0) }
        )
    }
    
    /// Makes network request with `JSON` parameters and returns `Decodable` or `Error`.
    public func entity<Entity: Decodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any],
        entityType: Entity.Type,
        completion: @escaping (Result<Entity, Error>) -> Void
    ) {
        networkRequestService.requestBodyParameterMethodTask(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { JSONEncoderService.data(from: $0) },
            decode: { JSONDecoderService.entity(from: $0) }
        )
    }

    /// Makes network request with `Encodable` parameters and returns `Decodable` or `Error`.
    public func entity<Parameters: Encodable, Entity: Decodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        entityType: Entity.Type,
        completion: @escaping (Result<Entity, Error>) -> Void
    ) {
        networkRequestService.requestBodyParameterMethodTask(
            httpMethod: httpMethod,
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion,
            encode: { JSONEncoderService.data(from: $0) },
            decode: { JSONDecoderService.entity(from: $0) }
        )
    }
}