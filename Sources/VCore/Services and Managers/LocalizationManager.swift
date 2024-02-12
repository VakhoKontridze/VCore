//
//  LocalizationManager.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14/9/22.
//

import Foundation
import Combine
import OSLog

// MARK: - Localization Manager
/// Object that manages localization without interfacing to identifiers and `UserDefaults`.
///
/// `LocalizationManager` must be configured before `currentLocale` is accessed:
///
///     extension Locale {
///         static var english: Self { .init(identifier: "en") }
///         static var english_uk: Self { .init(identifier: "en-GB") }
///         static var spanish: Self { .init(identifier: "es") }
///     }
///
///     LocalizationManager.shared.addLocales([.english, .english_uk, .spanish])
///     LocalizationManager.shared.setDefaultLocale(to: .english)
///
/// Use the following method to change current `Locale`:
///
///     LocalizationManager.shared.setCurrentLocale(to: .english)
///
/// It's recommended that localizations are not enumerated just to use switch statement.
/// Enumerating will force the declaration of an identifier or a `RawValue`.
/// But `LocalizationManager` works on equivalence principle, where `"en"` and `"en-US"` are equivalent, if `Locale.current.regionCode` is `"US"`.
/// Use the following approach instead of switch statement:
///
///     if LocalizationManager.shared.currentLocale.isEquivalent(to: .english) {
///         ...
///     } else if LocalizationManager.shared.currentLocale.isEquivalent(to: .english_uk) {
///         ...
///     } else if LocalizationManager.shared.currentLocale.isEquivalent(to: .spanish) {
///         ...
///     } else {
///         fatalError()
///     }
///
public final class LocalizationManager { // TODO: iOS 17 - Convert to `Observable` and remove `Combine`
    // MARK: Properties - Singleton
    /// Shared instance of `LocalizationManager`.
    public static let shared: LocalizationManager = .init()
    
    // MARK: Properties - Current Locale
    /// Current `Locale`.
    ///
    /// It's important to differentiate `LocalizationManager.shared.currentLocale` and `Locale.current`.
    /// `LocalizationManager.shared.currentLocale` is `Locale` associated with the language either set through this object, or picked from the `iOS` settings.
    /// While `Locale.current` is `Locale` region from user's settings.
    ///
    /// To set property, refer to `setCurrentLocale(to:)` method.
    private(set) public lazy var currentLocale: Locale = getCurrentAppLocale()
    
    // MARK: Properties - Locales
    /// `Locales` that are added to the `LocalizationManager`.
    ///
    /// To set property, refer to `addLocale(_:)` or `addLocales(_:)` methods.
    private(set) public var locales: [Locale] = []
    
    private var _defaultLocale: Locale?

    // MARK: Properties - Default Locale
    /// Default `Locale` that will be retrieved in the absence of current value.
    ///
    /// To set property, refer to `setDefaultLocale(to:)` method.
    ///
    /// `Locale` passed to `setDefaultLocale(to:)` will not be first-choice default value.
    /// Instead, user's preferred `Locale` will be retrieved.
    /// If absent, specified default `Locale` will be used.
    /// To bypass this behavior, set `retrievesDefaultLocaleFromPreferences` to `false`.
    public var defaultLocale: Locale {
        if
            retrievesDefaultLocaleFromPreferences,
            let preferredLocale,
            validateIsAddedToManager(preferredLocale)
        {
            return preferredLocale
        }
        
        guard let _defaultLocale else {
            Logger.localizationManager.critical("`defaultLocale` is not set")
            fatalError()
        }

        return _defaultLocale
    }

    /// Indicates if default `Locale` is first retrieved from user's preferred `Locale`s,
    /// before referring to `Locale` passed to `setDefaultLocale(to:)`.
    public var retrievesDefaultLocaleFromPreferences: Bool = true

    // MARK: Properties - Misc
    /// `Publisher` that emits when current `Locale` changes.
    public let currentLocaleChangePublisher: PassthroughSubject<Locale, Never> = .init()
    
    private static var appleLanguagesUserDefaultsKey: String { "AppleLanguages" }
    
    // MARK: Initializers
    private init() {}
    
    // MARK: Configuration - Current Locale
    /// Sets current `Locale`.
    ///
    /// If `Locale` is not already added to `Bundle.main`, app will crash.
    ///
    /// If `Locale` is not already added to `LocalizationManager`, app will crash.
    public func setCurrentLocale(to locale: Locale) {
        assertIsAddedToBundle(locale)
        assertIsAddedToManager(locale)

        if !currentLocale.isEquivalent(to: locale) {
            currentLocale = locale
            setCurrentAppLocale(locale)

            currentLocaleChangePublisher.send(locale)
        }
    }
    
    // MARK: Configuration - Locales
    /// Adds `Locale` to `LocalizationManager`.
    ///
    /// If `Locale` is not already added to `Bundle.main`, app will crash.
    public func addLocale(_ locale: Locale) {
        addLocales([locale])
    }
    
    /// Adds `Array` of `Locale`s to `LocalizationManager`.
    ///
    /// If `Locale`s are not already added to `Bundle.main`, app will crash.
    public func addLocales(_ locales: [Locale]) {
        for locale in locales {
            assertIsAddedToBundle(locale)
            guard !validateIsAddedToManager(locale) else { continue }
            
            self.locales.append(locale)
        }
        
        for bundleLocale in bundleLocales {
            if
                !validateIsAddedToManager(bundleLocale) &&
                bundleLocale.identifier.lowercased() != "base"
            {
                Logger.localizationManager.warning("Localization '\(bundleLocale.identifier)' is not added to 'LocalizationManager'")
            }
        }
    }
    
    // MARK: Configuration - Default Locale
    /// Sets default `Locale`.
    ///
    /// This `Locale` will not be treated as first-choice default value,
    /// unless `retrievesDefaultLocaleFromPreferences` is set to `false`.
    /// For additional info, refer to `defaultLocale`.
    ///
    /// If `Locale` is not already added to `Bundle.main`, app will crash.
    ///
    /// If `Locale` is not already added to `LocalizationManager`, app will crash.
    public func setDefaultLocale(to locale: Locale) {
        assertIsAddedToBundle(locale)
        assertIsAddedToManager(locale)
        
        _defaultLocale = locale
    }

    // MARK: Localized - Strings File
    /// Returns localized `String` from the given table and bundle.
    ///
    /// This methods finds correct table path within the `Bundle`, once localization has changed.
    /// For additional info, refer to `LocalizationManager`.
    public func localizedInStringsFile(
        _ key: String,
        tableName: String? = nil,
        bundle: Bundle = .main,
        value: String = ""
    ) -> String {
        guard
            let path: String = Self.findStringsFileBundle(bundle: bundle, locale: currentLocale),
            let currentLocaleBundle: Bundle = .init(path: path)
        else {
            return value
        }

        return currentLocaleBundle.localizedString(
            forKey: key,
            value: value,
            table: tableName
        )
    }

    private static func findStringsFileBundle(
        bundle: Bundle,
        locale: Locale
    ) -> String? {
        let fileType: String = "lproj"

        return
            bundle.path(forResource: locale.identifier, ofType: fileType) ??
            bundle.path(forResource: locale.languageCode, ofType: fileType)  // Just in case "en_US" is passed, but file is called "en"
    }

    // MARK: Localized - String Catalog
    /// Returns localized `String` from the given table and bundle.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    public func localizedInStringCatalog(
        _ key: String,
        table: String? = nil,
        bundle: Bundle? = nil,
        locale: Locale = .current,
        comment: StaticString? = nil
    ) -> String {
        .init(
            localized: String.LocalizationValue(key),
            table: table,
            bundle: bundle,
            locale: locale,
            comment: comment
        )
    }

    // MARK: Bundle, Preferred Locale, Current Locale, and App Locales
    // COMMAND                                      PHYSICAL DEVICE                 SIMULATOR
    //
    // Bundle.main.localizations                    ["en", "es", "en-GB"]           ["en", "en-GB", "es"]
    // Bundle.main.preferredLocalizations           ["en"]                          ["en"]
    //
    // Locale.preferredLanguages                    ["en-US", "ka-US", "es-US"]     ["en"]
    // Locale.current.identifier                    "en_US"                         "en_US"
    //
    // UserDefaults.standard.value(forKey: "...")   ["en-US", "ka-US", "es-US"]     ["en"]
    
    private let bundleLocales: [Locale] = Bundle.main.localizations
        .map { Locale(identifier: $0) }
    
    private let preferredLocale: Locale? = Bundle.main.preferredLocalizations.first
        .map { Locale(identifier: $0) }
    
    private var currentAppLocale: Locale? {
        (UserDefaults.standard.value(forKey: Self.appleLanguagesUserDefaultsKey) as? [String])?.first.map { Locale(identifier: $0) }
    }
    
    private func getCurrentAppLocale() -> Locale {
        guard
            let currentAppLocale,
            validateIsAddedToManager(currentAppLocale)
        else {
            setCurrentAppLocale(defaultLocale)
            return defaultLocale
        }
        
        return currentAppLocale
    }
    
    private func setCurrentAppLocale(_ locale: Locale) {
        UserDefaults.standard.set([locale.identifier], forKey: Self.appleLanguagesUserDefaultsKey)
    }
    
    // MARK: Validation and Assertion
    private func assertIsAddedToBundle(_ locale: Locale) {
        guard bundleLocales.contains(where: { $0.isEquivalent(to: locale) }) else {
            Logger.localizationManager.critical("Localization '\(locale.identifier)' is not added to the 'Bundle.main' or no files are localized")
            fatalError()
        }
    }
    
    private func validateIsAddedToManager(_ locale: Locale) -> Bool {
        locales.contains(where: { $0.isEquivalent(to: locale) })
    }
    
    private func assertIsAddedToManager(_ locale: Locale) {
        guard validateIsAddedToManager(locale) else {
            Logger.localizationManager.critical("Localization '\(locale.identifier)' is not added to 'LocalizationManager'")
            fatalError()
        }
    }
}
