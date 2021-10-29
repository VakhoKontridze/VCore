//
//  NetworkError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - Network Error
/// An error that occurs during the network requests made by `NetworkService`.
public enum NetworkError: VCoreError {
    // MARK: Cases
    /// An indication that device is not connected to network.
    ///
    /// A check against `NetworkConnectionService` is made.
    case notConnectedToNetwork
    
    /// An indication that endpoint url is invalid.
    case invalidEndpoint
    
    /// An indication that parameters cannot be encoded.
    case incompleteParameters
    
    /// An indication that network ruquest returned an error.
    case returnedWithError
    
    /// An indication that netowrk ruquest returned an invalid response.
    case invalidResponse
    
    /// An indication that result cannot be decoded.
    case incompleteEntity
    
    // MARK: Properties
    // Overriden
    public static var errorDomain: String { "com.vcore.networkservice" }
    
    // MARK: VCore Error
    public var domain: String { Self.errorDomain }
    
    public var code: Int {
        switch self {
        case .notConnectedToNetwork: return 1
        case .invalidEndpoint: return 2
        case .incompleteParameters: return 3
        case .returnedWithError: return 4
        case .invalidResponse: return 5
        case .incompleteEntity: return 6
        }
    }
    
    public var description: String {
        switch self {
        case .notConnectedToNetwork: return "Not connected to network"
        case .invalidEndpoint: return "Cannot connect to the server. An incorrect handler is being used."
        case .incompleteParameters: return "Data cannot be encoded or is incomplete"
        case .returnedWithError: return "Server has encountered an error"
        case .invalidResponse: return "Server has returned an invalid response"
        case .incompleteEntity: return "Data cannot be decoded or is incomplete"
        }
    }
}
