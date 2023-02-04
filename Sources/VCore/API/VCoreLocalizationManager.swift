//
//  VCoreLocalizationManager.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.05.22.
//

import Foundation

// MARK: - V Core Localization Manager
/// Localization service that can be used to localize the package.
///
/// `localizationProvider` in `shared` instance can be set to override the localized values.
///
///     struct SomeLocalizationProvider: VCoreLocalizationProvider { ... }
///
///     VCoreLocalizationManager.shared.localizationProvider = SomeLocalizationProvider()
///
/// Alternately, consider using `VCoreHumanReadableLocalizationProvider`
/// that automatically localized errors from `DefaultLocalizationProvider`, and only exposes human-readable `String`s.
public final class VCoreLocalizationManager {
    // MARK: Properties
    /// Shared instance of `VCoreLocalizationManager`.
    public static let shared: VCoreLocalizationManager = .init()
    
    /// Localization provider. Defaults to `DefaultVCoreLocalizationProvider`.
    public var localizationProvider: any VCoreLocalizationProvider = DefaultVCoreLocalizationProvider()
    
    // MARK: Initializers
    private init() {}
}

// MARK: - V Core Localization Provider
/// Localization provider in package.
///
/// Alternately, consider using `VCoreHumanReadableLocalizationProvider`
/// that automatically localized errors from `DefaultLocalizationProvider`, and only exposes human-readable `String`s.
public protocol VCoreLocalizationProvider {
    /// Localized value for `NetworkClientError`'s description.
    func networkClientErrorDescription(_ networkClientError: NetworkClientError.Code) -> String
    
    /// Localized value for `JSONEncoderError`'s description.
    func jsonEncoderErrorDescription(_ jsonEncoderError: JSONEncoderError.Code) -> String
    
    /// Localized value for `JSONDecoderError`'s description.
    func jsonDecoderErrorDescription(_ jsonDecoderError: JSONDecoderError.Code) -> String
    
    /// Localized value for `JSONDecoderError`'s description.
    func keychainServiceErrorDescription(_ keychainServiceError: KeychainServiceError.Code) -> String
    
    /// Localized value for error title in alerts.
    var alertErrorTitle: String { get }
    
    /// Localized value for `ok` button in alerts.
    var alertOKButtonTitle: String { get }
    
    /// Localized value for error description thrown by `get` method in `ResultNoFailure`.
    var resultNoFailureErrorDescription: String { get }
}

// MARK: - V Core Human-Readable Localization Provider
/// Localization provider in package that automatically localized errors from `DefaultLocalizationProvider`,
/// and only exposes human-readable `String`s.
public protocol VCoreHumanReadableLocalizationProvider: VCoreLocalizationProvider {}

extension VCoreHumanReadableLocalizationProvider {
    public func networkClientErrorDescription(_ networkClientError: NetworkClientError.Code) -> String {
        DefaultVCoreLocalizationProvider().networkClientErrorDescription(networkClientError)
    }
    
    public func jsonEncoderErrorDescription(_ jsonEncoderError: JSONEncoderError.Code) -> String {
        DefaultVCoreLocalizationProvider().jsonEncoderErrorDescription(jsonEncoderError)
    }
    
    public func jsonDecoderErrorDescription(_ jsonDecoderError: JSONDecoderError.Code) -> String {
        DefaultVCoreLocalizationProvider().jsonDecoderErrorDescription(jsonDecoderError)
    }
    
    public func keychainServiceErrorDescription(_ keychainServiceError: KeychainServiceError.Code) -> String {
        DefaultVCoreLocalizationProvider().keychainServiceErrorDescription(keychainServiceError)
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
    public func networkClientErrorDescription(_ networkClientError: NetworkClientError.Code) -> String {
        switch networkClientError {
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
    
    public func jsonEncoderErrorDescription(_ jsonEncoderError: JSONEncoderError.Code) -> String {
        switch jsonEncoderError {
        case .failedToEncode: return "Data cannot be encoded or is incomplete"
        case .failedToDecode: return "Data cannot be decoded or is incomplete"
        case .failedToCast: return "Data cannot be encoded or is incomplete"
        }
    }
    
    public func jsonDecoderErrorDescription(_ jsonDecoderError: JSONDecoderError.Code) -> String {
        switch jsonDecoderError {
        case .failedToDecode: return "Data cannot be decoded or is incomplete"
        case .failedToEncode: return "Data cannot be encoded or is incomplete"
        case .failedToCast: return "Data cannot be decoded or is incomplete"
        }
    }
    
    public func keychainServiceErrorDescription(_ keychainServiceError: KeychainServiceError.Code) -> String {
        switch keychainServiceError {
        case .failedToGet: return "Data cannot be retrieved"
        case .failedToSet: return "Data cannot be set"
        case .failedToDelete: return "Data cannot be deleted"
        case .failedToCast: return "Data cannot be retrieved"
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
