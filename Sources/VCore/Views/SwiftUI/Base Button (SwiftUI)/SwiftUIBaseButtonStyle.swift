//
//  SwiftUIBaseButtonStyle.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.03.23.
//

import SwiftUI

// MARK: - Swift UI Base Button Style
struct SwiftUIBaseButtonStyle<Label>: ButtonStyle where Label: View {
    // MARK: Properties
    private let appearance: SwiftUIBaseButtonAppearance
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    private func internalState(_ isPressed: Bool) -> SwiftUIBaseButtonState {
        .init(
            isEnabled: isEnabled,
            isPressed: isPressed
        )
    }
    
    private let label: (GenericState_EnabledPressedDisabled) -> Label
    
    // MARK: Initializers
    init(
        appearance: SwiftUIBaseButtonAppearance,
        @ViewBuilder label: @escaping (GenericState_EnabledPressedDisabled) -> Label
    ) {
        self.appearance = appearance
        self.label = label
    }
    
    // MARK: Body
    func makeBody(configuration: Configuration) -> some View {
        let state: SwiftUIBaseButtonState = internalState(configuration.isPressed)

        return label(state)
            .background { configuration.label }
            .applyIf(!appearance.animatesStateChange) {
                $0
                    .animation(nil, value: isEnabled)
                    .animation(nil, value: configuration.isPressed)
            }
    }
}
