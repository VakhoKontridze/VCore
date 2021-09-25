//
//  NetworkService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - Network Service
/// Network service that performs network data tasks
///
/// Object is not inheritable, but can be extended the following way:
///
/// ```
/// struct SomeNetworkService {
///     func getJSON(
///         endpoint: String,
///         headers: [String :Any],
///         parameters: [String: Any],
///         completion: @escaping (Result<[String: Any], NetworkError>) -> Void
///     ) {
///         NetworkService.shared.GET.json(
///             endpoint: endpoint,
///             headers: headers,
///             parameters: parameters,
///             completion: { result in
///                 switch result {
///                 case .success(let json):
///                     guard NetworkTypeCaster.toBool(json["success"]) == true else {
///                         completion(.failure(.returnedWithError(.init(
///                             domain: "SomeApp.SomeNetworkService",
///                             code: NetworkTypeCaster.toInt(json["code"]) ?? 1,
///                             description: NetworkTypeCaster.toString(json["message"]) ?? "Returned with error"
///                         ))))
///                         return
///                     }
///
///                     guard let data = NetworkTypeCaster.toJSON(json["data"]) else {
///                         completion(.failure(.incompleteEntity(.init(
///                             domain: "SomeApp.SomeNetworkService",
///                             code: 2,
///                             description: "Cannot retrieve data"
///                         ))))
///                         return
///                     }
///
///                     completion(.success(data))
///
///                 case .failure(let error):
///                     completion(.failure(error))
///                 }
///             }
///         )
///     }
/// }
/// ```
///
public final class NetworkService {
    // MARK: Properties
    /// Network service that performs GET network data tasks
    public let GET: NetworkGETService = .init()
    
    /// Network service that performs POST network data tasks
    public let POST: NetworkPOSTService = .init()
    
    /// Queue on which completion is returned. Defaults to `main`.
    public var queue: DispatchQueue = .main
    
    /// Timeout inteval for request. Has a default value from `URLSessionConfiguration.default`, and defaults to `60`.
    public var timeoutIntervalForRequest: TimeInterval = URLSessionConfiguration.default.timeoutIntervalForRequest
    
    /// Timeout inteval for request. Has a default value resource `URLSessionConfiguration.default`, and defaults to `604800`.
    public var timeoutIntervalForResource: TimeInterval = URLSessionConfiguration.default.timeoutIntervalForResource
    
    /// Shared instance of `NetworkService`
    public static let shared: NetworkService = .init()
    
    // MARK: Initializers
    private init() {}
}
