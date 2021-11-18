import Foundation

// MARK: - Localization Service
final class LocalizationService {
    // MARK: Properties - Locale
    lazy var locale: Locale = getLocale()
        {
            didSet {
                guard locale != oldValue else { return }
                setLocale(locale)
                postNotification()
            }
        }
    
    var locales: [Locale] { Locale.supportedLocales }
    
    // MARK: Properties - Notiifcations
    static var notificationName: NSNotification.Name { .init("LocalizationService.LocaleChanged") }
    
    // MARK: Properties - Misc
    private static var userDefaultsKey: String { "LocalizationService.LocaleID" }
    
    // MARK: Properties - Singleton
    static let shared: LocalizationService = .init()
    
    // MARK: Initializers
    private init() {}

    // MARK: Locale
    enum Locale: Identifiable, CaseIterable {
        // MARK: Cases
        case english

        // MARK: Properties
        var id: String {
            switch self {
            case .english: return "en"
            }
        }
        
        static var supportedLocales: [Locale] {
            Bundle.main
                .localizations
                .filter { $0 != "Base" }
                .compactMap { .init(id: $0) }
        }
        
        var displayName: String? {
            NSLocale(localeIdentifier: LocalizationService.shared.locale.id)
                .displayName(forKey: .identifier, value: id)
        }
        
        // MARK: Initializers
        init?(id: String) {
            guard let locale: Self = .allCases.first(where: { $0.id == id }) else { return nil }
            self = locale
        }
        
        static var `default`: Self { .english }
    }

    // MARK: Get / Set
    private func getLocale() -> Locale {
        guard
            Self.userDefaultsKey.isUserDefaultsKey(),
            let id: String = UserDefaults.standard.string(forKey: Self.userDefaultsKey),
            let locale: Locale = .allCases.first(where: { $0.id == id })
        else {
            setLocale(.default)
            return .default
        }
        
        return locale
    }
    
    private func setLocale(_ locale: Locale) {
        UserDefaults.standard.set(locale.id, forKey: Self.userDefaultsKey)
    }

    // MARK: Notifications
    private func postNotification() {
        NotificationCenter.default.post(name: Self.notificationName, object: self, userInfo: nil)
    }
}

// MARK: - Localization
extension String {
    var localized: String {
        guard
            let path: String = Bundle.main.path(forResource: LocalizationService.shared.locale.id, ofType: "lproj"),
            let bundle: Bundle = .init(path: path)
        else {
            return self
        }

        return bundle.localizedString(forKey: self, value: nil, table: nil)
    }
}
