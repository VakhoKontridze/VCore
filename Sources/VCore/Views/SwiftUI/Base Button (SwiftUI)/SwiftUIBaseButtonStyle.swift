//
//  SwiftUIBaseButtonStyle.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.03.23.
//

import SwiftUI

// MARK: - SwiftUI Base Button Style
struct SwiftUIBaseButtonStyle<Label>: ButtonStyle where Label: View {
    // MARK: Properties
    private let uiModel: SwiftUIBaseButtonUIModel
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    private func state(isPressed: Bool) -> SwiftUIBaseButtonState { .init(isEnabled: isEnabled, isPressed: isPressed) }
    
    private let label: (GenericState_EnabledPressedDisabled) -> Label
    
    // MARK: Initializers
    init(
        uiModel: SwiftUIBaseButtonUIModel,
        @ViewBuilder label: @escaping (GenericState_EnabledPressedDisabled) -> Label
    ) {
        self.uiModel = uiModel
        self.label = label
    }
    
    // MARK: Body
    func makeBody(configuration: Configuration) -> some View {
        label(state(isPressed: configuration.isPressed))
            .background(content: { configuration.label })
            .applyIf(!uiModel.animatesStateChange, transform: {
                $0
                    .animation(nil, value: isEnabled)
                    .animation(nil, value: configuration.isPressed)
            })
    }
}
