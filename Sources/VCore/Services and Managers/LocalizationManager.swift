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
/// Object that manages localization without interfacing with identifiers and `UserDefaults`.
///
/// You can localize `String`s with a simple `extension`:
///
///     extension String {
///         var localized: String {
///             LocalizationManager.shared.localize(self)
///         }
///     }
///
/// You can create a simple localization picker, although it would require relaunch for `Bundle` to be updated:
///
///     @ObservedObject private var localizationManager: LocalizationManager = .shared
///
///     VStack(content: {
///         ForEach(
///             LocalizationManager.locales.sorted(by: { (lhs, rhs) in
///                 lhs.displayNameNative
///                     .isOptionalLess(
///                         than: rhs.displayNameNative,
///                         order: .nilIsGreater,
///                         comparison: { $0.compare($1, options: .caseInsensitive) == .orderedAscending }
///                     )
///             }),
///             id: \.identifier,
///             content: { locale in
///                 Button(
///                     action: {
///                         localizationManager.currentLocale = locale
///                     },
///                     label: {
///                         Text(locale.displayNameNative?.capitalized ?? locale.identifier)
///                             .fontWeight(localizationManager.currentLocale == locale ? .bold : .regular)
///                     }
///                 )
///             }
///         )
///     })
///
/// You can also preview localization by overriding `currentLocale`:
///
///     #Preview(body: {
///         LocalizationManager.shared.currentLocale = Locale(identifier: "es")
///
///         return ContentView()
///     })
///
public final class LocalizationManager: ObservableObject, @unchecked Sendable { // TODO: iOS 17.0 - Convert to `Observable` and remove `Combine`
    // MARK: Properties - Singleton
    /// Shared instance of `LocalizationManager`.
    public static let shared: LocalizationManager = .init()

    // MARK: Properties - Locales
    /// `Locale`s.
    public static let locales: [Locale] = Bundle.main.localizations
        .map({ Locale(identifier: $0) })

    // MARK: Properties - Default Locale
    @Published private var _defaultLocale: Locale

    /// Default `Locale` that will be retrieved in the absence of current value.
    public var defaultLocale: Locale {
        get {
            lock.withLock({
                _defaultLocale
            })
        }
        set {
            lock.withLock({
                _ = Self.validateLocaleIsAdded(newValue)
                
                _defaultLocale = newValue
            })
        }
    }

    // MARK: Properties - Current Locale
    @Published private var _currentLocale: Locale

    /// Current `Locale`.
    public var currentLocale: Locale {
        get {
            lock.withLock({
                _currentLocale
            })
        }
        set {
            lock.withLock({
                guard newValue != _currentLocale else { return }
                _ = Self.validateLocaleIsAdded(newValue)

                _currentLocale = newValue
                Self.setCurrentLocaleToUserDefaults(locale: newValue)
                currentLocaleChangePublisher.send(newValue)
            })
        }
    }

    // MARK: Properties - Publisher
    /// `Publisher` that emits when current `Locale` changes.
    public let currentLocaleChangePublisher: PassthroughSubject<Locale, Never> = .init()
    
    // MARK: Properties - Lock
    private let lock: NSRecursiveLock = .init()

    // MARK: Initializers
    private init() {
        let _defaultLocale: Locale = {
            guard
                let identifier: String = Bundle.main.preferredLocalizations.first
            else {
                Logger.localizationManager.critical("Default localization is not selected in 'Bundle.main'")
                fatalError()
            }

            return Locale(identifier: identifier)
        }()
        self._defaultLocale = _defaultLocale
        
        self._currentLocale = {
            if
                let currentLocaleUserDefaults: Locale = Self.getCurrentLocaleFromUserDefaults(),
                Self.validateLocaleIsAdded(currentLocaleUserDefaults)
            {
                return currentLocaleUserDefaults

            } else {
                let currentLocale: Locale = _defaultLocale
                Self.setCurrentLocaleToUserDefaults(locale: currentLocale)
                return currentLocale
            }
        }()
    }
    
    // MARK: User Defaults
    private static func getCurrentLocaleFromUserDefaults() -> Locale? {
        guard
            let identifier: String = (UserDefaults.standard.object(forKey: "AppleLanguages") as? [String])?.first,
            let locale: Locale = Self.locales.first(where: { $0.isEquivalent(to: Locale(identifier: identifier)) }) // Region code may be attached
        else {
            return nil
        }

        UserDefaults.standard.set([locale.identifier], forKey: "AppleLanguages") // Strips region code

        return locale
    }
    
    private static func setCurrentLocaleToUserDefaults(
        locale: Locale?
    ) {
        if let locale {
            UserDefaults.standard.set([locale.identifier], forKey: "AppleLanguages")
        } else {
            UserDefaults.standard.removeObject(forKey: "AppleLanguages")
        }
    }

    // MARK: Localization
    /// Returns localized `String` from the given table and `Bundle`.
    public func localize(
        _ key: String,
        table: String? = nil,
        bundle: Bundle? = nil,
        comment: StaticString? = nil
    ) -> String {
        .init(
            localized: String.LocalizationValue(key),
            table: table,
            bundle: bundle,
            locale: currentLocale,
            comment: comment
        )
    }

    // MARK: Validation
    private static func validateLocaleIsAdded(_ locale: Locale) -> Bool {
        guard Self.locales.contains(locale) else {
            Logger.localizationManager.warning("Localization '\(locale.identifier)' is not added to 'Bundle.main'")
            return false
        }

        return true
    }
}
