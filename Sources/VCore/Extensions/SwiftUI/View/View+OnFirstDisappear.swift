//
//  View+OnFirstDisappear.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27.01.24.
//

import SwiftUI

// MARK: - View + On First Disappear
extension View {
    /// Adds an action to perform before `View` disappears for the first time.
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .onFirstDisappear(perform: ...)
    ///     }
    ///
    public func onFirstDisappear(
        perform action: (() -> Void)? = nil
    ) -> some View {
        self
            .modifier(OnFirstDisappearModifier(action: action))
    }
}

// MARK: - On First Disappear Modifier
private struct OnFirstDisappearModifier: ViewModifier {
    // MARK: Properties
    private let action: (() -> Void)?

    @State private var didDisappearForTheFirstTime: Bool = false

    // MARK: Initializers
    init(
        action: (() -> Void)?
    ) {
        self.action = action
    }

    // MARK: Body
    func body(content: Content) -> some View {
        content
            .onDisappear {
                if !didDisappearForTheFirstTime {
                    didDisappearForTheFirstTime = true
                    action?()
                }
            }
    }
}

