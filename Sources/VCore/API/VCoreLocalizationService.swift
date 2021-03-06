//
//  VCoreLocalizationService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.05.22.
//

import Foundation

// MARK: - V Core Localization Service
/// Localization service that can be used to localize the package.
///
/// `localizationProvider` in `shared` instance can be set to override the localized values.
public final class VCoreLocalizationService {
    // MARK: Properties
    /// Shared instance of `VCoreLocalizationService`.
    public static let shared: VCoreLocalizationService = .init()
    
    /// Localization provider. Defaults to `DefaultVCoreLocalizationProvider`.
    public var localizationProvider: any VCoreLocalizationProvider = DefaultVCoreLocalizationProvider()
    
    // MARK: Initializers
    private init() {}
}

// MARK: - VCore Localization Provider
/// Localization provider in package.
public protocol VCoreLocalizationProvider {
    /// Localized value for `NetworkError`'s description.
    func networkErrorDescription(_ networkError: NetworkError) -> String
    
    /// Localized value for `JSONEncoderError`'s description.
    func jsonEncoderErrorDescription(_ jsonEncoderError: JSONEncoderError) -> String
    
    /// Localized value for `JSONDecoderError`'s description.
    func jsonDecoderErrorDescription(_ jsonDecoderError: JSONDecoderError) -> String
    
    /// Localized value for error title in alerts.
    var alertErrorTitle: String { get }
    
    /// Localized value for `ok` button in alerts.
    var alertOKButtonTitle: String { get }
    
    /// Localized value for error description thrown by `get` method in `ResultNoFailure`.
    var resultNoFailureErrorDescription: String { get }
}

// MARK: - VCore Human-Readable Localization Provider
/// Localization provider in package that automatically localized errors from `DefaultLocalizationProvider`, and only exposes human-readable`String`s
public protocol VCoreHumanReadableLocalizationProvider: VCoreLocalizationProvider {}

extension VCoreHumanReadableLocalizationProvider {
    public func networkErrorDescription(_ networkError: NetworkError) -> String {
        DefaultVCoreLocalizationProvider().networkErrorDescription(networkError)
    }
    
    public func jsonEncoderErrorDescription(_ jsonEncoderError: JSONEncoderError) -> String {
        DefaultVCoreLocalizationProvider().jsonEncoderErrorDescription(jsonEncoderError)
    }
    
    public func jsonDecoderErrorDescription(_ jsonDecoderError: JSONDecoderError) -> String {
        DefaultVCoreLocalizationProvider().jsonDecoderErrorDescription(jsonDecoderError)
    }
    
    public var resultNoFailureErrorDescription: String {
        DefaultVCoreLocalizationProvider().resultNoFailureErrorDescription
    }
}

// MARK: - Default VCore Localization Provider
/// Defaults VCore localization provider.
public struct DefaultVCoreLocalizationProvider: VCoreLocalizationProvider {
    // MARK: Initializers
    /// Initializes `DefaultVCoreLocalizationProvider`.
    public init() {}
    
    // MARK: VCore Localization Provider
    public func networkErrorDescription(_ networkError: NetworkError) -> String {
        switch networkError {
        case .notConnectedToNetwork: return "Not connected to network"
        case .invalidEndpoint: return "Cannot connect to the server. An incorrect handler is being used."
        case .invalidPathParameters: return "Data cannot be encoded or is incomplete"
        case .invalidQueryParameters: return "Data cannot be encoded or is incomplete"
        case .invalidHeaders: return "Data cannot be encoded or is incomplete"
        case .invalidBody: return "Data cannot be encoded or is incomplete"
        case .requestTimedOut: return "Request has timed out"
        case .returnedWithError: return "Server has encountered an error"
        case .invalidResponse: return "Server has returned an invalid response"
        case .invalidData: return "Data cannot be decoded or is incomplete"
        }
    }
    
    public func jsonEncoderErrorDescription(_ jsonEncoderError: JSONEncoderError) -> String {
        switch jsonEncoderError {
        case .failedToEncode: return "Data cannot be encoded or is incomplete"
        }
    }
    
    public func jsonDecoderErrorDescription(_ jsonDecoderError: JSONDecoderError) -> String {
        switch jsonDecoderError {
        case .failedToDecode: return "Data cannot be decoded or is incomplete"
        }
    }
    
    public var alertErrorTitle: String {
        "Something Went Wrong"
    }
    
    public var alertOKButtonTitle: String {
        "Ok"
    }
    
    public var resultNoFailureErrorDescription: String {
        "No data"
    }
}
