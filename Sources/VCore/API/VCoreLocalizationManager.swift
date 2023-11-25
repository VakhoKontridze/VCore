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
    /// Localized value for error title in alerts.
    var alertErrorTitle: String { get }
    
    /// Localized value for `ok` button in alerts.
    var alertOKButtonTitle: String { get }

    /// Localized value for `done` button in `ResponderChainUIToolbar` and `View.responderChainToolbar(...)`.
    var responderChainToolbarDoneButtonTitle: String { get }
}

// MARK: - Default VCore Localization Provider
/// Defaults VCore localization provider.
public struct DefaultVCoreLocalizationProvider: VCoreLocalizationProvider {
    // MARK: Initializers
    /// Initializes `DefaultVCoreLocalizationProvider`.
    public init() {}
    
    // MARK: VCore Localization Provider
    public var alertErrorTitle: String { "Something Went Wrong" }
    public var alertOKButtonTitle: String { "Ok" }

    public var responderChainToolbarDoneButtonTitle: String { "Done" }
}
