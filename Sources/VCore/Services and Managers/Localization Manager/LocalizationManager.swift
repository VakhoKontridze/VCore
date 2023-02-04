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
///     LocalizationManager.shared.setCurrentLocale(
///         to: .english,
///         replaceLocalizationTableInBundles: [.main]
///     )
///
/// It's recommended that you do not enumerate localizations just to be able to use switch-case.
/// Enumerating will force you to declare an identifier or a `RawValue`.
/// But `LocalizationManager` works on equivalence principle, where "en" and "en-US" are equivalent, if `Locale.current.regionCode.
/// Use the following approach instead of switch-case:
///
///     extension Locale {
///         static var english: Self { .init(identifier: "en") }
///         static var english_uk: Self { .init(identifier: "en-GB") }
///         static var spanish: Self { .init(identifier: "es") }
///     }
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
/// When setting current `Locale`, optionally, you can pass `Bundle`s in `replaceLocalizationTableInBundles` argument
/// to replace localization table without having to restart the app.
///
/// However, replacing localization tables doesn't re-launch app, like changing a language does from `iOS` settings.
/// To achieve this behavior in `UIKit`, replace `rootViewController`.
/// For `SwiftUI`, refer to and use `ViewResettingContainer`.
public final class LocalizationManager {
    // MARK: Properties - Singleton
    /// Shared instance of `LocalizationManager`.
    public static let shared: LocalizationManager = .init()

    // MARK: Properties - Locales
    /// Current `Locale`.
    ///
    /// It's important to keep in mind what differentiates `LocalizationManager.shared.currentLocale`
    /// and `Locale.current`.
    /// `LocalizationManager.shared.currentLocale` is `Locale` associated with the language either set through this object,or picker from `iOS` settings.
    /// While `Locale.current` is `Locale` region from user's settings.
    ///
    /// To set property, refer to `setCurrentLocale(to:replaceLocalizationTableInBundles)` method.
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
    /// Optionally, you can pass `Bundle`s in `replaceLocalizationTableInBundles` argument
    /// to replace localization table without having to restart the app.
    ///
    /// However, replacing localization tables doesn't re-launch app, like changing a language does from `iOS` settings.
    /// To achieve this behavior in `UIKit`, replace `rootViewController`.
    /// For `SwiftUI`, refer to and use `ViewResettingContainer`.
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

            bundles?.forEach { replaceLocalizationTable(toLocale: locale, inBundle: $0) }
            
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
            guard !validateIsAdded(locale) else { return }

            self.locales.append(locale)
        }
        
        for bundleLocale in bundleLocales {
            if !validateIsAdded(bundleLocale) {
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
        .map { .init(identifier: $0) }
    
    private let preferredLocale: Locale? = Bundle.main.preferredLocalizations.first
        .map { .init(identifier: $0) }

    private var currentAppLocale: Locale? {
        (UserDefaults.standard.value(forKey: Self.appleLanguagesUserDefaultsKey) as? [String])?.first.map { .init(identifier: $0) }
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
        assert(
            bundleLocales.contains(where: { $0.isEquivalent(to: locale) }),
            "Localization `\(locale.identifier)` is not added to the `Bundle.main`"
        )
    }
    
    private func validateIsAdded(_ locale: Locale) -> Bool {
        locales.contains(where: { $0.isEquivalent(to: locale) })
    }
    
    private func assertIsAdded(_ locale: Locale) {
        assert(
            validateIsAdded(locale),
            "Localization `\(locale.identifier)` is not added to `LocalizationManager`"
        )
    }

    // MARK: Replacing Localization Table
    private func replaceLocalizationTable(
        toLocale locale: Locale,
        inBundle bundle: Bundle
    ) {
        guard
            let bundleIdentifier: String = bundle.bundleIdentifier,
            let path: String =
                bundle.path(forResource: locale.identifier, ofType: "lproj") ??
                bundle.path(forResource: locale.languageCode, ofType: "lproj") // Just in case "en_US" is passed, but file is called "en"
        else {
            return
        }

        _ = object_setClass(bundle, LocalizationTableReplacingBundle.self)
        LocalizationTableReplacingBundle.localizationTablePaths[bundleIdentifier] = path
    }
}

// MARK: - Helpers
extension Array where Element == String {
    fileprivate func removingBaseLocalization() -> [String] {
        filter { $0 != "Base" }
    }
}
