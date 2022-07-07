//
//  SwiftUIBaseButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if os(iOS)

import SwiftUI

// MARK: - Swift UI Base Button
/// A `SwiftUI` `View` that can be used as a base for all interactive views and buttons.
///
/// `Bool` can also be passed as state.
///
/// One implementation of `SwiftUIBaseButton` is using it as a base for another button.
/// In this case, `SwiftUIBaseButton` would handle state and clicks on it's own,
/// allowing a custom button to focus on UI and API.
///
/// Model:
///
///     struct SomeButtonUIModel {
///         static let titleColor: StateColors = .init(
///             enabled: .black,
///             pressed: .gray,
///             disabled: .gray
///         )
///
///         private init() {}
///
///         typealias StateColors = GenericStateModel_EnabledPressedDisabled<Color>
///     }
///
/// State:
///
///     typealias SomeButtonInternalState = GenericState_EnabledPressedDisabled
///
/// Button:
///
///     struct SomeButton: View {
///         private typealias UIModel = SomeButtonUIModel
///
///         @Environment(\.isEnabled) private var isEnabled: Bool
///         @State private var isPressed: Bool = false
///         private var internalState: SomeButtonInternalState { .init(isEnabled: isEnabled, isPressed: isPressed) }
///
///         private let action: () -> Void
///
///         private let title: String
///
///         init(
///             action: @escaping () -> Void,
///             title: String
///         ) {
///             self.action = action
///             self.title = title
///         }
///
///         var body: some View {
///             SwiftUIBaseButton(gesture: gestureHandler, label: {
///                 Text(title)
///                     .foregroundColor(UIModel.titleColor.value(for: internalState))
///             })
///                 .disabled(!internalState.isEnabled)
///         }
///
///         private func gestureHandler(gestureState: BaseButtonGestureState) {
///             isPressed = gestureState.isPressed
///             if gestureState.isClicked { action() }
///         }
///     }
///
///     var body: some View {
///         SomeButton(
///             action: { print("Clicked") },
///             title: "Lorem Ipsum"
///         )
///     }
///
public struct SwiftUIBaseButton<Label>: View where Label: View {
    // MARK: Properties
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    private var gestureHandler: (BaseButtonGestureState) -> Void
    
    private let label: () -> Label
    
    // MARK: Initializers
    /// Initializes `SwiftUIBaseButton` with gesture handler and label.
    public init(
        gesture gestureHandler: @escaping (BaseButtonGestureState) -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.gestureHandler = gestureHandler
        self.label = label
    }
    
    /// Initializes `SwiftUIBaseButton` with action and label.
    public init(
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.gestureHandler = { gestureState in if gestureState.isClicked { action() } }
        self.label = label
    }

    // MARK: Body
    public var body: some View {
        label()
            .overlay(SwiftUIBaseButtonViewRepresentable(
                isEnabled: isEnabled,
                gesture: gestureHandler
            ))
    }
}

// MARK: - Preview
struct SwiftUIBaseButton_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIBaseButton(
            gesture: { gestureState in
                switch gestureState {
                case .none: print("-")
                case .press: print("Pressing")
                case .click: print("Clicked")
                }
            },
            label: { Text("Lorem Ipsum") }
        )
    }
}

#endif
