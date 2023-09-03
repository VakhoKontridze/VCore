//
//  VCoreLocalizationManager.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.05.22.
//

import Foundation

// MARK: - V Core Localization Manager
/// Object that manages localization in the package.
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
    
    /// Localization provider. Set to `DefaultVCoreLocalizationProvider`.
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
    /// Localized value for `KeychainServiceError`'s description.
    func keychainServiceErrorDescription(_ keychainServiceError: KeychainServiceError.Code) -> String
    
    /// Localized value for error title in alerts.
    var alertErrorTitle: String { get }
    
    /// Localized value for `ok` button in alerts.
    var alertOKButtonTitle: String { get }
    
    /// Localized value for error description thrown by `get` method in `ResultNoFailure`.
    var resultNoFailureErrorDescription: String { get }

    /// Localized value for `done` button in `ResponderChainToolBar` and `View.responderChainToolBar(...)`.
    var responderChainToolBarDoneButtonTitle: String { get }
}

// MARK: - V Core Human-Readable Localization Provider
/// Localization provider in package that automatically localized errors from `DefaultLocalizationProvider`,
/// and only exposes human-readable `String`s.
public protocol VCoreHumanReadableLocalizationProvider: VCoreLocalizationProvider {}

extension VCoreHumanReadableLocalizationProvider {
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

    public var responderChainToolBarDoneButtonTitle: String {
        "Done"
    }
}
