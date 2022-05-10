//
//  NetworkError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - Network Error
/// An error that occurs during the network requests made by `NetworkClient`.
public enum NetworkError: Int, VCoreError, CaseIterable {
    // MARK: Cases
    /// Indicates that device is not connected to network.
    ///
    /// A check against `NetworkConnectionService` is made.
    case notConnectedToNetwork
    
    /// Indicates that endpoint url is invalid.
    case invalidEndpoint
    
    /// Indicates that request has timed out.
    case requestTimedOut
    
    /// Indicates that path parameters are invalid.
    case invalidPathParameters
    
    /// Indicates that query parameters are invalid.
    case invalidQueryparameters
    
    /// Indicates that headers are invalid.
    case invalidHeaders
    
    /// Indicates that body is invalid.
    case invalidBody
    
    /// Indicates that network ruquest returned an error.
    case returnedWithError
    
    /// Indicates that netowrk ruquest returned an invalid response.
    case invalidResponse
    
    /// Indicates that result cannot be decoded.
    case invalidData
    
    // MARK: Properties
    // Overriden
    public static var errorDomain: String { "com.vcore.networkclient" }
    
    // MARK: VCore Error
    public var domain: String { Self.errorDomain }
    
    public var code: Int { 1000 + (rawValue+1) }
    
    public var description: String {
        switch self {
        case .notConnectedToNetwork: return "Not connected to network"
        case .invalidEndpoint: return "Cannot connect to the server. An incorrect handler is being used."
        case .invalidPathParameters: return "Data cannot be encoded or is incomplete"
        case .invalidQueryparameters: return "Data cannot be encoded or is incomplete"
        case .invalidHeaders: return "Data cannot be encoded or is incomplete"
        case .invalidBody: return "Data cannot be encoded or is incomplete"
        case .requestTimedOut: return "Request has timed out"
        case .returnedWithError: return "Server has encountered an error"
        case .invalidResponse: return "Server has returned an invalid response"
        case .invalidData: return "Data cannot be decoded or is incomplete"
        }
    }
}
