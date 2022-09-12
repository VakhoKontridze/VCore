//
//  NetworkClientError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK: - Network Client Error
/// An error that occurs during the network requests made by `NetworkClient`.
public struct NetworkClientError: VCoreError, Equatable {
    // MARK: Properties
    private let _code: Code
    
    // MARK: VCore Error
    public var code: Int { _code.rawValue }
    public var description: String { VCoreLocalizationService.shared.localizationProvider.networkClientErrorDescription(_code) }
    
    // MARK: Initializers
    init(_ code: Code) {
        self._code = code
    }
    
    /// Indicates that device is not connected to network.
    ///
    /// A check against `NetworkConnectionService` is made.
    public static var notConnectedToNetwork: Self { .init(.notConnectedToNetwork) }
    
    /// Indicates that endpoint url is invalid.
    public static var invalidEndpoint: Self { .init(.invalidEndpoint) }
    
    /// Indicates that request has timed out.
    public static var requestTimedOut: Self { .init(.requestTimedOut) }
    
    /// Indicates that path parameters are invalid.
    public static var invalidPathParameters: Self { .init(.invalidPathParameters) }
    
    /// Indicates that query parameters are invalid.
    public static var invalidQueryParameters: Self { .init(.invalidQueryParameters) }
    
    /// Indicates that headers are invalid.
    public static var invalidHeaders: Self { .init(.invalidHeaders) }
    
    /// Indicates that body is invalid.
    public static var invalidBody: Self { .init(.invalidBody) }
    
    /// Indicates that network request returned an error.
    public static var returnedWithError: Self { .init(.returnedWithError) }
    
    /// Indicates that network request returned an invalid response.
    public static var invalidResponse: Self { .init(.invalidResponse) }
    
    /// Indicates that result cannot be decoded.
    public static var invalidData: Self { .init(.invalidData) }
    
    // MARK: Code
    /// Error code.
    public enum Code: Int, Equatable {
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
    }
    
    // MARK: Equatable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.code == rhs.code
    }
}
