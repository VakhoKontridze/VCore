//
//  NetworkResponseProcessor.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import Foundation

// MARK: - Network Response Processor
/// Processor that processes `Error`, `Response,` and `Data`, before they are analyzed and`Data` is decoded.
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
///         func error(_ error: Error) throws {}
///
///         func response(_ data: Data, _ response: URLResponse) throws -> URLResponse {
///             if response.isSuccessHTTPStatusCode { return response }
///
///             guard let json: [String: Any?] = try? JSONDecoderService.json(data: data) else { return response }
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
///                 let json: [String: Any?] = try? JSONDecoderService.json(data: data),
///                 let dataJSON: [String: Any?] = json["data"]?.toJSON,
///                 let dataData: Data = try? JSONEncoderService.data(encodable: dataJSON)
///             else {
///                 throw SomeNetworkError(code: 1, description: "Incomplete Data")
///             }
///
///             return dataData
///         }
///     }
///
public protocol NetworkResponseProcessor {
    /// Processes`Error`.
    func error(_ error: Error) throws
    
    /// Processes `Response`.
    func response(_ data: Data, _ response: URLResponse) throws -> URLResponse
    
    /// Processes `Data`.
    func data(_ data: Data, _ response: URLResponse) throws -> Data
}

// MARK: - Default Network Processor
struct DefaultNetworkResponseProcessor: NetworkResponseProcessor {
    func error(_ error: Error) throws {}
    
    func response(_ data: Data, _ response: URLResponse) throws -> URLResponse {
        response
    }
    
    func data(_ data: Data, _ response: URLResponse) throws -> Data {
        data
    }
}
