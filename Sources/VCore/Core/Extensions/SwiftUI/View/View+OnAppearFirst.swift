//
//  View+OnAppearFirst.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI

extension View {
    /// Adds an action to perform before `View` appears with flag indicating if it's first.
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .onAppear { isFirst in
    ///                 ...
    ///             }
    ///     }
    ///
    public func onAppear(
        perform action: ((Bool) -> Void)? = nil
    ) -> some View {
        self
            .modifier(OnAppearFirstModifier(action: action))
    }
}

private struct OnAppearFirstModifier: ViewModifier {
    // MARK: Properties
    private let action: ((Bool) -> Void)?

    @State private var hasAppeared: Bool = false

    // MARK: Initializers
    init(
        action: ((Bool) -> Void)?
    ) {
        self.action = action
    }

    // MARK: Body
    func body(content: Content) -> some View {
        content
            .onAppear {
                let isFirst: Bool = !hasAppeared
                hasAppeared = true
                
                action?(isFirst)
            }
    }
}
