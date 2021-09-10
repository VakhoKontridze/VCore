//
//  NetworkError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK:- Network Error
/// An error that occurs during the network requests made by `NetworkService`
public enum NetworkError: Error, LocalizedError {
    // MARK: Cases
    /// An indication that device is not connected to network.
    ///
    /// A check against `NetworkConnectionService` is made
    case notConnectedToNetwork
    
    /// An indication that endpoint url is invalid
    case invalidEndpoint
    
    /// An indication that parameters cannot be encoded
    ///
    /// Associated values contain code and description of error
    case incompleteParameters(code: Int?, description: String?)
    
    /// An indication that network ruquest returned an error
    ///
    /// Associated values contain code and description of error
    case returnedWithError(code: Int?, description: String?)
    
    /// An indication that netowrk ruquest returned an invalid response
    ///
    /// Associated values contain code and description of error
    case invalidResponse(code: Int?, description: String?)
    
    /// An indication that result cannot be decoded
    ///
    /// Associated values contain code and description of error
    case incompleteEntity(code: Int?, description: String?)

    // MARK: Code
    /// Error code
    public var code: Int? {
        switch self {
        case .notConnectedToNetwork: return nil
        case .invalidEndpoint: return nil
        case .incompleteParameters(let code, _): return code
        case .returnedWithError(let code, _): return code
        case .invalidResponse(let code, _): return code
        case .incompleteEntity(let code, _): return code
        }
    }
    
    // MARK: Description
    /// Error description
    public var errorDescription: String? {
        switch (primaryDescription, secondaryDescription) {
        case (nil, _):
            return nil
            
        case (let primaryDescription?, nil):
            return primaryDescription
            
        case (var primaryDescription?, let secondaryDescription?):
            if primaryDescription.last == "." { _ = primaryDescription.removeLast() }
            return "\(primaryDescription). \(secondaryDescription)."
        }
    }
    
    /// Primary error description
    public var primaryDescription: String? {
        switch self {
        case .notConnectedToNetwork: return "Not connected to the network"
        case .invalidEndpoint: return "Cannot connect to the server. An incorrect handler is being used."
        case .incompleteParameters: return "Incomplete data is being sent to the server"
        case .returnedWithError: return "Server has encountered an error"
        case .invalidResponse: return "Server has returned an invalid response"
        case .incompleteEntity: return "Server has returned an incomplete data"
        }
    }
    
    /// Secondary error description
    ///
    /// Returned from associated error description
    public var secondaryDescription: String? {
        switch self {
        case .notConnectedToNetwork: return nil
        case .invalidEndpoint: return nil
        case .incompleteParameters(_, let description): return description
        case .returnedWithError(_, let description): return description
        case .invalidResponse(_, let description): return description
        case .incompleteEntity(_, let description): return description
        }
    }
}

// MARK:- JSON Coder Bridge
extension Result where Failure == JSONEncodingError {
    var asResultWithNetworkError: Result<Success, NetworkError> {
        switch self {
        case .success(let data):
            return .success(data)
        
        case .failure(let error):
            return .failure(.incompleteParameters(
                code: error.code,
                description: error.localizedDescription
            ))
        }
    }
}

extension Result where Failure == JSONDecodingError {
    var asResultWithNetworkError: Result<Success, NetworkError> {
        switch self {
        case .success(let data):
            return .success(data)
        
        case .failure(let error):
            return .failure(.incompleteEntity(
                code: error.code,
                description: error.localizedDescription
            ))
        }
    }
}
