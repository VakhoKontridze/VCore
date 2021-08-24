//
//  NetworkService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK:- Network Service
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
///         NetworkService.GET.json(
///             endpoint: endpoint,
///             headers: headers,
///             parameters: parameters,
///             completion: { result in
///                 switch result {
///                 case .success(let json):
///                     guard NetworkTypeCaster.toBool(json["success"]) == true else {
///                         let code: Int? = NetworkTypeCaster.toInt(json["code"])
///                         let description: String? = NetworkTypeCaster.toString(json["message"])
///
///                         completion(.failure(.returnedWithError(code: code, description: description)))
///                         return
///                     }
///
///                     guard let data = NetworkTypeCaster.toJSON(json["data"]) else {
///                         completion(.failure(.incompleteEntity(code: nil, description: nil)))
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
public struct NetworkService {
    // MARK: Initializers
    private init() {}
}
