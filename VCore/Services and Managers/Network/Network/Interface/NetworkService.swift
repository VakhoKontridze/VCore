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
///         static let someApp: NetworkService = .init(
///             postProcessor: SomeAppNetworkServicePostProcessor()
///         )
///     }
///
///     struct SomeAppNetworkServicePostProcessor: NetworkServicePostProcessor {
///         func postProcess(
///             response: response: URLResponse?,
///             data: Data
///         ) -> Result<Data, Error> {
///             switch JSONDecoderService.json(from: data) {
///             case .success(let json):
///                 guard json["success"].toBool == true else {
///                     return .failure(NetworkError.returnedWithError(.init(
///                         domain: "com.SomeApp",
///                         code: json["code"].toInt ?? 1,
///                         description: json["message"].toString ?? "Returned with error"
///                     )))
///                 }
///
///                 guard let dataJSON: [String: Any] = json["data"].toJSON else {
///                     return .failure(NetworkError.incompleteEntity(.init(
///                         domain: "com.SomeApp",
///                         code: 2,
///                         description: "Cannot retrieve data"
///                     )))
///                 }
///
///                 switch JSONEncoderService.data(from: dataJSON) {
///                 case .success(let dataData):
///                     return .success(dataData)
///
///                 case .failure(let error):
///                     return .failure(NetworkError.incompleteEntity(.init(
///                         domain: (error as NSError).domain,
///                         code: (error as NSError).code,
///                         description: "Cannot decode data"
///                     )))
///                 }
///
///             case .failure(let error):
///                 return .failure(NetworkError.incompleteEntity(.init(nsError: error as NSError)))
///             }
///         }
///     }
///
/// Usage example:
///
///     NetworkService.someApp.POST.json(
///         endpoint: "https://httpbin.org/post",
///         headers: [
///             "Accept": "application/json",
///             "Content-Type": "application/json"
///         ],
///         parameters: [
///             "someKey": "someValue"
///         ],
///         completion: { result in
///             guard case .success(let json) = result else { return }
///             print(json["json"].toJSON?["someKey"].toString ?? "-")
///         }
///     )
///
public final class NetworkService {
    // MARK: Properties - Objects
    /// Default instance of `NetworkService`.
    public static let `default`: NetworkService = .init(
        postProcessor: DefaultNetworkServicePostProcessor()
    )
    
    private let postProcessor: NetworkServicePostProcessor
    private lazy var networkRequestService: NetworkRequestService = .init(
        networkService: self,
        postProcessor: postProcessor
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
    /// Queue on which completion is returned. Defaults to `main`.
    public var queue: DispatchQueue = .main
    
    /// Timeout inteval for request. Has a default value from `URLSessionConfiguration.default`, and defaults to `60`.
    public var timeoutIntervalForRequest: TimeInterval = URLSessionConfiguration.default.timeoutIntervalForRequest
    
    /// Timeout inteval for request. Has a default value resource `URLSessionConfiguration.default`, and defaults to `604800`.
    public var timeoutIntervalForResource: TimeInterval = URLSessionConfiguration.default.timeoutIntervalForResource
    
    // MARK: Initializers
    /// Initializes `NetworkService`.
    public init(postProcessor: NetworkServicePostProcessor) {
        self.postProcessor = postProcessor
    }
}
