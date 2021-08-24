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
    /// As associated values, this case contains the code and description of error
    case incompleteParameters(code: Int?, description: String?)
    
    /// An indication that network ruquest returned an error
    ///
    /// As associated values, this case contains the code and description of error
    case returnedWithError(code: Int?, description: String?)
    
    /// An indication that netowrk ruquest returned an invalid response
    ///
    /// As associated values, this case contains the code and description of error
    case invalidResponse(code: Int?, description: String?)
    
    /// An indication that result cannot be decoded
    ///
    /// As associated values, this case contains the code and description of error
    case incompleteEntity(code: Int?, description: String?)
    
    /// An indication that other error has occured
    ///
    /// As associated values, this case contains the code and description of error, as well as raw unprocessed error.
    ///
    /// `rawError` may include:
    /// - `NSError` from `JSONSerialization`
    /// - `EncodingError` from `JSONEncoder`
    /// - `DecodingError` from `JSONDecoder`
    case other(code: Int?, description: String?, rawError: Error?)
    
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
        case .other(let code, _, _): return code
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
        case .other: return nil
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
        case .other(_, let description, _): return description
        }
    }
    
    // MARK: Initializers
    /// Casts error to `NetworkError.other`
    public static func other(from error: Error) -> Self {
        .other(
            code: (error as NSError).code,
            description: error.localizedDescription,
            rawError: error
        )
    }
    
    /// Convenience initializer for `NetworkError.other` without any associate types
    public static func other() -> Self {
        .other(
            code: nil,
            description: nil,
            rawError: nil
        )
    }
}
