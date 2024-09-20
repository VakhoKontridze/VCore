//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import SwiftUI

// MARK: - Localization Manager
extension LocalizationManager {
    @available(*, deprecated, message: "Use `static` property instead")
    public var locales: [Locale] {
        Self.locales
    }
}
