//
//  LocalizationManagerLocalizationProvider.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.02.23.
//

import Foundation

// MARK: - Localization Manager Localization Provider
/// Data source provider that allows for a convenient configuration of `LocalizationManager`.
///
/// This is not a recommended way for interfacing with `LocalizationManager`,
/// but is otherwise given as an option if you wish to enumerate languages.
///
///     enum Language: LocalizationManagerLocalizationProvider {
///         case english
///         case english_uk
///         case spanish
///
///         static var `default`: Self { .english }
///
///         var id: String {
///             switch self {
///             case .english: return "en"
///             case .english_uk: return "en-GB"
///             case .spanish: return "es"
///             }
///         }
///     }
///
///     LocalizationManager.shared.addLocaleAndSetDefaultLocale(
///         fromLocalizationProvider: Language.self
///     )
///
/// Use the following method to change `Locale`:
///
///     LocalizationManager.shared.setCurrentLocale(
///         fromLocalization: Language.english,
///         replaceLocalizationTableInBundles: [.main]
///     )
///
public protocol LocalizationManagerLocalizationProvider: CaseIterable {
    /// `Locale` identifier.
    var id: String { get }
    
    /// Default `Locale`.
    static var `default`: Self { get }
}

extension LocalizationManagerLocalizationProvider {
    /// Initializes `Locale` with specified `id`.
    public func toLocale() -> Locale {
        .init(identifier: id)
    }
}
