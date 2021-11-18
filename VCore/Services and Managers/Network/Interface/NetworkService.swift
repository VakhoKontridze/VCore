//
//  NetworkService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - Network Service
/// Network service that performs network data tasks.
///
/// Object is not inheritable, but can be extended the following way:
///
///     extension NetworkService {
///         static let someInstance: NetworkService = .init(
///             processor: SomeNetworkServiceProcessor()
///         )
///     }
///
///     struct SomeNetworkError: Error {
///         let domain: String = "com.somecompany.someapp"
///         var code: Int
///         var description: String
///     }
///
///     struct SomeNetworkServiceProcessor: NetworkServiceProcessor {
///         func error(_ error: Error) throws {}
///
///         func response(_ data: Data, _ response: URLResponse) throws -> URLResponse {
///             if response.isValid { return response }
///
///             guard let json: [String: Any?] = try? JSONDecoderService.json(from: data) else { return response }
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
///             let json: [String: Any?] = try JSONDecoderService.json(from: data)
///
///             guard let dataJSON: [String: Any?] = json["json"]?.toJSON else { throw SomeNetworkError(code: 1, description: "Incomplete Data") }
///
///             let dataData: Data = try JSONEncoderService.data(from: dataJSON)
///
///             return dataData
///         }
///     }
///
/// Usage example:
///
///     Task(operation: {
///         do {
///             let json: [String: Any?] = try await NetworkService.someInstance.POST.json(
///                 endpoint: "https://httpbin.org/post",
///                 headers: [
///                     "Accept": "application/json",
///                     "Content-Type": "application/json"
///                 ],
///                 parameters: [
///                     "someKey": "someValue"
///                 ]
///             )
///
///             print(json["someKey"].toString ?? "-")
///
///         } catch let error {
///             print(error.localizedDescription)
///         }
///     })
///
public final class NetworkService {
    // MARK: Properties - Objects
    /// Default instance of `NetworkService`.
    public static let `default`: NetworkService = .init(
        processor: DefaultNetworkServiceProcessor()
    )
    
    private let processor: NetworkServiceProcessor
    private lazy var networkRequestService: NetworkRequestService = .init(
        networkService: self,
        processor: processor
    )
    
    // MARK: Properties - Methods
    /// Network service that performs `GET` network data tasks.
    private(set) public lazy var GET: NetworkGETRequestMethodService = .init(networkRequestService)
    
    /// Network service that performs` POST` network data tasks.
    private(set) public lazy var POST: NetworkPOSTRequestMethodService = .init(networkRequestService)
    
    /// Network service that performs` PUT` network data tasks.
    private(set) public lazy var PUT: NetworkPUTRequestMethodService = .init(networkRequestService)
    
    /// Network service that performs` PATCH` network data tasks.
    private(set) public lazy var PATCH: NetworkPATCHRequestMethodService = .init(networkRequestService)
    
    /// Network service that performs` DELETE` network data tasks.
    private(set) public lazy var DELETE: NetworkDELETERequestMethodService = .init(networkRequestService)
    
    // HEAD
    
    // CONNECT
    
    // OPTIONS
    
    // TRACE
    
    // MARK: Properties - Misc    
    /// Timeout inteval for request. Has a default value from `URLSessionConfiguration.default`, and defaults to `60`.
    public var timeoutIntervalForRequest: TimeInterval = URLSessionConfiguration.default.timeoutIntervalForRequest
    
    /// Timeout inteval for request. Has a default value from `URLSessionConfiguration.default`, and defaults to `604800`.
    public var timeoutIntervalForResource: TimeInterval = URLSessionConfiguration.default.timeoutIntervalForResource
    
    // MARK: Initializers
    /// Initializes `NetworkService`.
    public init(processor: NetworkServiceProcessor) {
        self.processor = processor
    }
}
