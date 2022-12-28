//
//  NetworkRequestMethod.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import Foundation

// MARK: - Network Request Method
/// `HTTP` method for `NetworkService`.
///
///     var request: NetworkRequest = .init(url: ...)
///     request.method = .POST
///
public enum NetworkRequestMethod: Int, CaseIterable {
    // MARK: Cases
    /// `GET` request method.
    case GET
    
    /// `POST` request method.
    case POST
    
    /// `PUT` request method.
    case PUT
    
    /// `PATCH` request method.
    case PATCH
    
    /// `DELETE` request method.
    case DELETE
    
    /// `HEAD` request method.
    case HEAD
    
    /// `CONNECT` request method.
    case CONNECT
    
    /// `OPTIONS` request method.
    case OPTIONS
    
    /// `TRACE` request method.
    case TRACE
    
    // MARK: Properties
    /// `HTTP` method.
    var httpMethod: String {
        switch self {
        case .GET: return "GET"
        case .POST: return "POST"
        case .PUT: return "PUT"
        case .PATCH: return "PATCH"
        case .DELETE: return "DELETE"
        case .HEAD: return "HEAD"
        case .CONNECT: return "CONNECT"
        case .OPTIONS: return "OPTIONS"
        case .TRACE: return "TRACE"
        }
    }
}
