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
    case invalidQueryParameters
    
    /// Indicates that headers are invalid.
    case invalidHeaders
    
    /// Indicates that body is invalid.
    case invalidBody
    
    /// Indicates that network request returned an error.
    case returnedWithError
    
    /// Indicates that network request returned an invalid response.
    case invalidResponse
    
    /// Indicates that result cannot be decoded.
    case invalidData
    
    // MARK: VCore Error
    public static var errorDomain: String { "com.vcore.networkclient" }
    public var code: Int { 1000 + rawValue }
    public var description: String { VCoreLocalizationService.shared.localizationProvider.networkErrorDescription(self) }
}
