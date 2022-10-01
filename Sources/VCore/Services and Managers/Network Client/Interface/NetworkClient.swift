//
//  NetworkClient.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - Network Client
/// Client that performs network tasks.
///
/// Object contains default instance `default`, that can be used to make requests.
///
///     func fetchData() async {
///         do {
///             var request: NetworkRequest = .init(url: "https://httpbin.org/post")
///             request.method = .POST
///             try request.addHeaders(encodable: JSONRequestHeaders())
///             try request.addBody(json: ["key": "value"])
///
///             let result: [String: Any?] = try await NetworkClient.default.json(from: request)
///
///             print(result["json"]?.toUnwrappedJSON["key"]?.toString ?? "-")
///
///         } catch {
///             print(error.localizedDescription)
///         }
///     }
///
public final class NetworkClient {
    // MARK: Properties
    /// Default instance of `NetworkClient`.
    public static let `default`: NetworkClient = .init(
        responseProcessor: DefaultNetworkResponseProcessor()
    )
    
    /// Configuration object that defines behavior and policies for an `URL` session.
    public var sessionConfiguration: URLSessionConfiguration = .default
    
    /// Queue on which completion is returned. Defaults to `main`.
    public var completionQueue: DispatchQueue = .main
    
    /*private*/ let responseProcessor: any NetworkResponseProcessor
    
    // MARK: Initializers
    /// Initializes `NetworkClient`.
    public init(responseProcessor: any NetworkResponseProcessor) {
        self.responseProcessor = responseProcessor
        
        NetworkReachabilityService.shared.configure()
    }
}
