//
//  View.OnFirstAppear.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI

// MARK: - View on First Appear
extension View {
    /// Adds an action to perform before `View` appears for the first time.
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .onFirstAppear(perform: { ... })
    ///     }
    ///
    public func onFirstAppear(
        perform action: (() -> Void)? = nil
    ) -> some View {
        self
            .modifier(OnFirstAppearModifier(action: action))
    }
}

// MARK: - On First Appear Modifier
private struct OnFirstAppearModifier: ViewModifier {
    // MARK: Properties
    private let action: (() -> Void)?

    @State private var didAppearForTheFirstTime: Bool = false

    // MARK: Initializers
    init(
        action: (() -> Void)?
    ) {
        self.action = action
    }

    // MARK: Body
    func body(content: Content) -> some View {
        content
            .onAppear(perform: {
                if !didAppearForTheFirstTime {
                    didAppearForTheFirstTime = true
                    action?()
                }
            })
    }
}
