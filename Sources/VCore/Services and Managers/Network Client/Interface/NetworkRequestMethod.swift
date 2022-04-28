//
//  NetworkRequestMethod.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import Foundation

// MARK: - Network Request Method
/// `HTTP` method for `NetworkServie`.
public enum NetworkRequestMethod: Int, CaseIterable {
    // MARK: Cases
    /// `GET` reqeust method.
    case GET
    
    /// `POST` reqeust method.
    case POST
    
    /// `PUT` reqeust method.
    case PUT
    
    /// `PATCH` reqeust method.
    case PATCH
    
    /// `DELETE` reqeust method.
    case DELETE
    
    /// `HEAD` reqeust method.
    case HEAD
    
    /// `CONNECT` reqeust method.
    case CONNECT
    
    /// `OPTIONS` reqeust method.
    case OPTIONS
    
    /// `TRACE` reqeust method.
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
