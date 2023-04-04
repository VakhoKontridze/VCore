//
//  LocalizationManager.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14/9/22.
//

import Foundation

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
/// It's recommended that you do not enumerate localizations just to be able to use switch statement.
/// Enumerating will force you to declare an identifier or a `RawValue`.
/// But `LocalizationManager` works on equivalence principle, where "en" and "en-US" are equivalent, if `Locale.current.regionCode` is "US".
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
/// Major challenge with localization on iOS is reading values from correct localization table.
/// `NSLocalizedString(...)` will not read values from localization table you have switched to.
/// There are two solutions here.
///
/// First option, is to use `LocalizationManager.shared.localized(...)` method that finds correct table path
/// within the `Bundle` and reads values from it. Alternately, you can use `String.localizedWithManager(...)`.
///
/// Second option, is to replace the `Bundle` `class` with a sub-`class` that overrides table path internally.
/// Advantage of this approach is that `NSLocalizedString(...)` will return correct values.
/// To override a `class`, use `replaceLocalizationTableInBundles` parameter when changing a localization.
///
///     LocalizationManager.shared.setCurrentLocale(
///         to: .english,
///         replaceLocalizationTableInBundles: [.main]
///     )
///
/// However, replacing localization tables doesn't re-launch app, like changing a language does from `iOS` settings.
/// To achieve this behavior in `UIKit`, replace `rootViewController` inside `AppDelegate`/`SceneDelegate`.
/// In `SwiftUI`, use `ViewResettingContainer` and trigger `View` resets when you change localization.
public final class LocalizationManager {
    // MARK: Properties - Singleton
    /// Shared instance of `LocalizationManager`.
    public static let shared: LocalizationManager = .init()

    // MARK: Properties - Locales
    /// Current `Locale`.
    ///
    /// It's important to differentiate `LocalizationManager.shared.currentLocale` and `Locale.current`.
    /// `LocalizationManager.shared.currentLocale` is `Locale` associated with the language either set through this object,or picker from `iOS` settings.
    /// While `Locale.current` is `Locale` region from user's settings.
    ///
    /// To set property, refer to `setCurrentLocale(to:replaceLocalizationTableInBundles:)` method.
    private(set) public lazy var currentLocale: Locale = getCurrentAppLocale()

    /// `Locales` that are added to the `LocalizationManager`.
    ///
    /// To set property, refer to `addLocale(_:)` or `addLocales(_:)` methods.
    private(set) public var locales: [Locale] = []
    
    private var _defaultLocale: Locale!

    /// Default `Locale` that will be retrieved in the absence of current value.
    ///
    /// To set property, refer to `setDefaultLocale(to:)` method.
    ///
    /// `Locale` passed to `setDefaultLocale(to:)` will not be first-choice default value.
    /// Instead, user's preferred `Locale` will be retrieved.
    /// If absent, specified default `Locale` will be used.
    /// To bypass this behavior, set `retrievesDefaultLocaleFromPreferences` to `false.`
    public var defaultLocale: Locale! {
        if
            retrievesDefaultLocaleFromPreferences,
            let preferredLocale,
            validateIsAdded(preferredLocale)
        {
            return preferredLocale
        }

        return _defaultLocale
    }

    // MARK: Properties - Misc
    /// Indicates if default `Locale` is first retrieved from user's preferred `Locale`s,
    /// before referring to `Locale` pass to `setDefaultLocale(to:)`.
    public var retrievesDefaultLocaleFromPreferences: Bool = true

    /// Notification that indicates that the user’s locale changed.
    public static var currentLocaleDidChangeNotification: Notification.Name { NSLocale.currentLocaleDidChangeNotification }

    private static var appleLanguagesUserDefaultsKey: String { "AppleLanguages" }

    // MARK: Initializers
    private init() {}

    // MARK: Configuration - Current Locale
    /// Sets current `Locale`.
    ///
    /// Optionally, you can pass `Bundle` `Array` in `replaceLocalizationTableInBundles` argument
    /// to replace `Bundle` `class` with a sub-`class` that overrides table path internally,
    /// that reads values form correct localization table.
    /// For additional info, refer to `LocalizationManager`.
    ///
    /// If `Locale` is not already added to `Bundle.main`, app will crash.
    ///
    /// If `Locale` is not already added to `LocalizationManager`, app will crash.
    public func setCurrentLocale(
        to locale: Locale,
        replaceLocalizationTableInBundles bundles: [Bundle]? = nil
    ) {
        assertIsAddedToBundle(locale)
        assertIsAdded(locale)
        
        if !currentLocale.isEquivalent(to: locale) {
            currentLocale = locale
            setCurrentAppLocale(locale)

            bundles?.forEach { LocalizationTableOverridingBundle.overrideTable(toLocale: locale, inBundle: $0) }
            
            NotificationCenter.default.post(name: Self.currentLocaleDidChangeNotification, object: self, userInfo: nil)
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
            guard !validateIsAdded(locale) else { continue }

            self.locales.append(locale)
        }
        
        for bundleLocale in bundleLocales {
            if
                !validateIsAdded(bundleLocale) &&
                bundleLocale.identifier.lowercased() != "base"
            {
                VCoreLogWarning("Localization `\(bundleLocale.identifier)` is not added to `LocalizationManager`")
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
        assertIsAdded(locale)

        _defaultLocale = locale
    }

    // MARK: Bundle, Preferred, Current, and App Locales
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
            validateIsAdded(currentAppLocale)
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
            VCoreFatalError("Localization `\(locale.identifier)` is not added to the `Bundle.main` or no files are localized")
        }
    }
    
    private func validateIsAdded(_ locale: Locale) -> Bool {
        locales.contains(where: { $0.isEquivalent(to: locale) })
    }
    
    private func assertIsAdded(_ locale: Locale) {
        guard validateIsAdded(locale) else {
            VCoreFatalError("Localization `\(locale.identifier)` is not added to `LocalizationManager`")
        }
    }
}

// MARK: - Helpers
extension Array where Element == String {
    fileprivate func removingBaseLocalization() -> [String] {
        filter { $0.lowercased() != "base" }
    }
}
