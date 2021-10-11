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
    ///
    /// Associated value contains info of `VCoreErrorInfo` type.
    case incompleteParameters(_ info: VCoreErrorInfo)
    
    /// An indication that network ruquest returned an error.
    ///
    /// Associated value contains info of `VCoreErrorInfo` type.
    case returnedWithError(_ info: VCoreErrorInfo)
    
    /// An indication that netowrk ruquest returned an invalid response.
    ///
    /// Associated value contains info of `VCoreErrorInfo` type.
    case invalidResponse(_ info: VCoreErrorInfo)
    
    /// An indication that result cannot be decoded.
    ///
    /// Associated value contains info of `VCoreErrorInfo` type.
    case incompleteEntity(_ info: VCoreErrorInfo)
    
    // MARK: Properties
    public var info: VCoreErrorInfo? {
        switch self {
        case .notConnectedToNetwork: return nil
        case .invalidEndpoint: return nil
        case .incompleteParameters(let info): return info
        case .returnedWithError(let info): return info
        case .invalidResponse(let info): return info
        case .incompleteEntity(let info): return info
        }
    }

    // Overriden
    /// Primary error description.
    public var localizedDescription: String? {
        switch self {
        case .notConnectedToNetwork: return "Not connected to the network"
        case .invalidEndpoint: return "Cannot connect to the server. An incorrect handler is being used."
        default: return info?.description
        }
    }
}

// MARK: - JSON Coder Bridge
extension Result where Failure == JSONEncoderError {
    var toResultWithNetworkError: Result<Success, NetworkError> {
        switch self {
        case .success(let data):
            return .success(data)
        
        case .failure(let error):
            return .failure(.incompleteParameters(.init(
                domain: error.domain,
                code: error.code,
                description: error.localizedDescription
            )))
        }
    }
}

extension Result where Failure == JSONDecoderError {
    var toResultWithNetworkError: Result<Success, NetworkError> {
        switch self {
        case .success(let data):
            return .success(data)
        
        case .failure(let error):
            return .failure(.incompleteEntity(.init(
                domain: error.domain,
                code: error.code,
                description: error.localizedDescription
            )))
        }
    }
}
