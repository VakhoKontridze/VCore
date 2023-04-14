//
//  CustomDismissAction.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14.04.23.
//

import SwiftUI

// MARK: - Custom Dismiss Action
/// Custom action that dismisses a presentation.
///
/// For additional info, refer to `View.customDismissAction(_:)` method.
public struct CustomDismissAction {
    // MARK: Properties
    /// Dismiss action.
    public let action: () -> Void
    
    // MARK: Initializers
    /// Initializes `CustomDismissAction` with dismiss action.
    public init(
        _ action: @escaping () -> Void
    ) {
        self.action = action
    }
    
    init() {
        self.action = {}
    }
    
    // MARK: Callable Object
    public func callAsFunction() {
        action()
    }
}
