//
//  CustomDismissActionEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14.04.23.
//

import SwiftUI

// MARK: - Custom Dismiss Action Environment Value
extension EnvironmentValues {
    /// Custom action that dismisses a presentation.
    public var customDismissAction: CustomDismissAction {
        get { self[CustomDismissActionEnvironmentKey.self] }
        set { self[CustomDismissActionEnvironmentKey.self] = newValue }
    }
}

// MARK: - Custom Dismiss Action Environment Key
struct CustomDismissActionEnvironmentKey: EnvironmentKey {
    static let defaultValue: CustomDismissAction = .init()
}
