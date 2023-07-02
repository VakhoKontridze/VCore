//
//  LocalizationKeyProvider.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.07.23.
//

import Foundation

// MARK: - Localization Key Provider
/// `protocol` that allows for convenient localization by providing a localization key.
///
/// `LocalizationKeyProvider` is meant to be extended by defining a custom localizer method.
/// This allows your project to integrate in multi-modular system.
///
/// The following can be declared at an individual module level, in order retrieve the `current` module.
/// For single-module projects, this step can be skipped.
///
///     private final class BundleSeeker {}
///     extension Bundle {
///         static let current: Bundle = .init(for: BundleSeeker.self)
///         public static var submodule: Bundle { current } // For retrieving `Bundle` from main module
///     }
///
/// Each module, or even individual files, should define a custom localizer method.
///
///     extension LocalizationKeyProvider {
///         var localized: String {
///             LocalizationManager.shared.localized(key, bundle: .current)
///         }
///     }
///
/// `Localizable.strings`.
///
///     ...
///     "screens.home.hello_world" = "Hello, World!"
///     ...
///
/// Once system is implemented, localization objects can be defined for individual scopes.
///
///     enum HomeLocalizedStrings: String, LocalizationKeyProvider {
///         case hello_world
///
///         var key: String { "screens.home.\(rawValue)" }
///     }
///
///     final class HomeViewController: UIViewController {
///         private typealias LocStrings = HomeLocalizedStrings
///
///         override func viewDidLoad() {
///            super.viewDidLoad()
///
///            title = LocStrings.hello_world.localized
///         }
///     }
///
/// The system can also be support multiple tables, by either defining multiple localizer methods, or by passing a table name.
///
///     extension LocalizationKeyProvider {
///         var tableName: String? { nil }
///     }
///
///     extension LocalizationKeyProvider {
///         var localized: String {
///             LocalizationManager.shared.localized(
///                 key,
///                 tableName: tableName,
///                 bundle: .current
///             )
///         }
///     }
///
///     enum HomeLocalizedStrings: String, LocalizationKeyProvider {
///         case hello_world
///
///         var key: String { "screens.home.\(rawValue)" }
///         var tableName: String? { "Localizable2.strings" }
///     }
///
public protocol LocalizationKeyProvider {
    /// Localization key.
    var key: String { get }
}
