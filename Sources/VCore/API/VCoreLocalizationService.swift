//
//  VCoreLocalizationService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.05.22.
//

import Foundation

// MARK: - V Core Localization Service
/// Localization Service that can be used to localize the package.
///
/// `localizationProvider` in `shared` instance can be set to override the localized values.
public final class VCoreLocalizationService {
    // MARK: Properties
    /// Shared instance of `VCoreLocalizationService`.
    public static let shared: VCoreLocalizationService = .init()
    
    /// Localization provider. Defaults to `DefaultVCoreLocalizationProvider`.
    public var localizationProvider: VCoreLocalizationProvider = DefaultVCoreLocalizationProvider()
    
    // MARK: Initializers
    private init() {}
}

// MARK: - VCore Localization Provider
/// Localization provider in package.
public protocol VCoreLocalizationProvider {
    /// Localzied value for `NetworkError`.
    func value(networkError: NetworkError) -> String
    
    /// Localzied value for `JSONEncoderError`.
    func value(jsonEncoderError: JSONEncoderError) -> String
    
    /// Localzied value for `JSONDecoderError`.
    func value(jsonDecoderError: JSONDecoderError) -> String
}

// MARK: - Default VCore Localization Provider
/// Defaults VCore Localization Provider.
public struct DefaultVCoreLocalizationProvider: VCoreLocalizationProvider {
    public func value(networkError: NetworkError) -> String {
        switch networkError {
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
    
    public func value(jsonEncoderError: JSONEncoderError) -> String {
        switch jsonEncoderError {
        case .failedToEncode: return "Data cannot be encoded or is incomplete"
        }
    }
    
    public func value(jsonDecoderError: JSONDecoderError) -> String {
        switch jsonDecoderError {
        case .failedToDecode: return "Data cannot be decoded or is incomplete"
        }
    }
}