//
//  NetworkRequestFactory.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK:- Network Request Factory
struct NetworkRequestFactory {
    private init() {}
}

// MARK:- Factory
extension NetworkRequestFactory {
    static func get(
        endpoint: String,
        headers: [String: Any],
        parameters: [String: Any]
    ) -> Result<URLRequest, NetworkError> {
        let requestType: NetworkRequestType = NetworkGETRequest()
        
        guard var urlComponents = URLComponents(string: endpoint) else { return .failure(.invalidEndpoint) }
        urlComponents.addItems(parameters)
        guard let url = urlComponents.url else { return .failure(.incompleteParameters(code: nil, description: nil)) }
        
        var request: URLRequest = .init(url: url)

        request.httpMethod = requestType.httpMethod

        request.addHTTPHeaders(requestType.httpHeaders)
        request.addHTTPHeaders(headers)

        return .success(request)
    }
    
    static func post(
        url: URL,
        headers: [String: Any],
        body: Data?
    ) -> URLRequest {
        let requestType: NetworkRequestType = NetworkPOSTRequest()
        
        var request: URLRequest = .init(url: url)

        request.httpMethod = requestType.httpMethod

        request.addHTTPHeaders(requestType.httpHeaders)
        request.addHTTPHeaders(headers)

        request.httpBody = body

        return request
    }
}

// MARK:- Headers
extension URLRequest {
    fileprivate mutating func addHTTPHeaders(_ items: [String: Any]) {
        guard !items.isEmpty else { return }
        
        items.forEach { (key, value) in addValue(.init(describing: value), forHTTPHeaderField: key) }
    }
}

// MARK:- GET Parameters
extension URLComponents {
    fileprivate mutating func addItems(_ items: [String: Any]) {
        guard !items.isEmpty else { return }
        
        switch queryItems {
        case nil: queryItems = items.map { .init($0) }
        case _?: items.forEach { queryItems?.append(.init($0)) }
        }
    }
}

extension URLQueryItem {
    fileprivate init(_ item: Dictionary<String, Any>.Element) {
        self.init(name: item.key, value: .init(describing: item.value))
    }
}
