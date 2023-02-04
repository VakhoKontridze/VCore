//
//  NetworkResponseProcessor.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import Foundation

// MARK: - Network Response Processor
/// Processor that processes `Response,` and `Data`, before they are analyzed and`Data` is decoded.
///
/// If success response is represented as:
///
///     {
///         "success": true,
///         "data": {
///             ...
///         }
///     }
///
/// and error response as:
///
///     {
///         "success": false,
///         "code": 401,
///         "message": "You are unauthorized"
///     }
///
/// then the following example performs proper processing.
/// Therefore, the purpose of response processing is not sacrificing `Decodable` protocol for entities,
/// that may be nested under `data` in response `JSON`;
/// also, retrieving error codes and messages independently from the entity.
///
///     extension NetworkClient {
///         static let someInstance: NetworkClient = .init(
///             processor: SomeNetworkClientProcessor()
///         )
///     }
///
///     struct SomeNetworkError: Error {
///         let domain: String = "com.somecompany.someapp"
///         var code: Int
///         var description: String
///     }
///
///     struct SomeNetworkClientProcessor: NetworkResponseProcessor {
///         func response(_ data: Data, _ response: URLResponse) throws -> URLResponse {
///             if response.isSuccessHTTPStatusCode { return response }
///
///             guard let json: [String: Any?] = try? JSONDecoderService().json(data: data) else { return response }
///             if json["success"]?.toBool == true { return response }
///
///             guard
///                 let code: Int = json["code"]?.toInt,
///                 let description: String = json["message"]?.toString
///             else {
///                 throw SomeNetworkError(code: 99, description: "Unknown Error")
///             }
///
///             throw SomeNetworkError(code: code, description: description)
///         }
///
///         func data(_ data: Data, _ response: URLResponse) throws -> Data {
///             guard
///                 let json: [String: Any?] = try? JSONDecoderService().json(data: data),
///                 let dataJSON: [String: Any?] = json["data"]?.toJSON,
///                 let dataData: Data = try? JSONEncoderService().data(encodable: dataJSON)
///             else {
///                 throw NetworkClientError.invalidData
///             }
///
///             return dataData
///         }
///     }
///
public protocol NetworkResponseProcessor {
    /// Processes `Response`.
    func response(_ data: Data, _ response: URLResponse) throws -> URLResponse
    
    /// Processes `Data`.
    func data(_ data: Data, _ response: URLResponse) throws -> Data
}

// MARK: - Default Network Processor
struct DefaultNetworkResponseProcessor: NetworkResponseProcessor {
    func response(_ data: Data, _ response: URLResponse) throws -> URLResponse {
        response
    }
    
    func data(_ data: Data, _ response: URLResponse) throws -> Data {
        data
    }
}
