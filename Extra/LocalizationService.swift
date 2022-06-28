import Foundation
import VCore

// MARK: - Localization Service
final class LocalizationService {
    // MARK: Properties
    static let shared: LocalizationService = .init()
    
    lazy var locale: SupportedLocale = getLocale()
        {
            didSet {
                guard locale != oldValue else { return }
                setLocale(locale)
                postNotification()
            }
        }
    
    static var currentLocaleDidChangeNotification: NSNotification.Name { NSLocale.currentLocaleDidChangeNotification }
    
    private static var appleLanguagesUserDefaultsKey: String { "AppleLanguages" }

    // MARK: Initializers
    private init() {
        for localeID in SupportedLocale.allCases.map({ $0.id }) where !SupportedLocale.systemLocaleIDs.contains(localeID) {
            fatalError("Locale `\(localeID)` is not added to the project")
        }
        
        for localeID in SupportedLocale.systemLocaleIDs where !SupportedLocale.allCases.map({ $0.id }).contains(localeID) {
            fatalError("Locale `\(localeID)` is not added to `LocalizationService.SupportedLocale`")
        }
    }
    
    // MARK: Supported Locale
    enum SupportedLocale: Identifiable, CaseIterable, KeyPathInitializableEnumeration {
        // MARK: Cases
        case english
        
        // MARK: Initializers
        static var `default`: Self { preferredSystemLocale ?? .english }
        
        // MARK: Properties
        var id: String {
            switch self {
            case .english: return "en"
            }
        }
        
        var displayName: String? {
            NSLocale(localeIdentifier: LocalizationService.shared.locale.id)
                .displayName(forKey: .identifier, value: id)
        }
        
        static let systemLocaleIDs: [String] = {
            Locale.preferredLanguages
                .map { $0.removingRegionCode() }
                .filter { Bundle.main.localizations.filter { $0 != "Base" }.contains($0) }
        }()
        
        static let preferredSystemLocaleID: String = Locale.current.identifier.removingRegionCode()
        static let preferredSystemLocale: Self? = .aCase(key: \.id, value: preferredSystemLocaleID)
    }
    
    // MARK: Get / Set
    private func getLocale() -> SupportedLocale {
        guard
            let languagesIDs: [String] = UserDefaults.standard.value(forKey: Self.appleLanguagesUserDefaultsKey) as? [String],
            let languageID: String = languagesIDs.first?.removingRegionCode(),
            let locale: SupportedLocale = .aCase(key: \.id, value: languageID)
        else {
            setLocale(.default)
            return .default
        }
        
        return locale
    }

    private func setLocale(_ locale: SupportedLocale) {
        guard
            var languageIDs: [String] = UserDefaults.standard.value(forKey: Self.appleLanguagesUserDefaultsKey) as? [String],
            let index: Int = languageIDs.firstIndex(of: {
                if let regionCode: String = Locale.current.regionCode {
                    return "\(locale.id)-\(regionCode)"
                } else {
                    return locale.id
                }
            }())
        else {
            return
        }
        
        languageIDs.insert(languageIDs.remove(at: index), at: 0)
        
        UserDefaults.standard.set(languageIDs, forKey: Self.appleLanguagesUserDefaultsKey)
    }
    
    // MARK: Notifications
    private func postNotification() {
        NotificationCenter.default.post(
            name: Self.currentLocaleDidChangeNotification,
            object: self,
            userInfo: nil
        )
    }
}

// MARK: - Localization
extension String {
    var localized: String {
        NSLocalizedString(
            self,
            tableName: nil,
            bundle: .main,
            value: "",
            comment: ""
        )
    }
}

// MARK: - Helpers
extension String {
    fileprivate func removingRegionCode() -> String {
        components(separatedBy: .init(["-", "_"])).first ?? self
    }
}
