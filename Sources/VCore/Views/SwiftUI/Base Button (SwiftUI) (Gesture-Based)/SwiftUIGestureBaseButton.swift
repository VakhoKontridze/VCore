//
//  SwiftUIGestureBaseButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

import SwiftUI

// MARK: - SwiftUI Gesture Base Button
/// `SwiftUI` `View` that can be used as a base for all interactive views and buttons.
///
/// `SwiftUIGestureBaseButton` can be used as a basis for all interactive UI components.
/// It can handle gestures and actions on it's own, allowing you to focus on UI and API.
///
/// Model:
///
///     struct SomeButtonUIModel {
///         var colors: Colors = .init()
///
///         struct Colors {
///             var title: StateColors = .init(
///                 enabled: .black,
///                 pressed: .gray,
///                 disabled: .gray
///             )
///
///             typealias StateColors = GenericStateModel_EnabledPressedDisabled<Color>
///         }
///     }
///
/// State:
///
///     typealias SomeButtonInternalState = GenericState_EnabledPressedDisabled
///
/// Button:
///
///     struct SomeButton: View {
///         private let uiModel: SomeButtonUIModel
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
///             uiModel: SomeButtonUIModel = .init(),
///             action: @escaping () -> Void,
///             title: String
///         ) {
///             self.uiModel = uiModel
///             self.action = action
///             self.title = title
///         }
///
///         var body: some View {
///             SwiftUIGestureBaseButton(
///                 onStateChange: stateChangeHandler,
///                 label: {
///                     Text(title)
///                         .foregroundColor(uiModel.colors.title.value(for: internalState))
///                 }
///             )
///                 .disabled(!internalState.isEnabled)
///         }
///
///         private func stateChangeHandler(gestureState: BaseButtonGestureState) {
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
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct SwiftUIGestureBaseButton<Label>: View where Label: View {
    // MARK: Properties
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    private var stateChangeHandler: (BaseButtonGestureState) -> Void
    
    private let label: () -> Label
    
    // MARK: Initializers
    /// Initializes `SwiftUIGestureBaseButton` with state change handler and label.
    public init(
        onStateChange stateChangeHandler: @escaping (BaseButtonGestureState) -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.stateChangeHandler = stateChangeHandler
        self.label = label
    }
    
    /// Initializes `SwiftUIGestureBaseButton` with action and label.
    public init(
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.stateChangeHandler = { gestureState in
            if gestureState.isClicked { action() }
        }
        self.label = label
    }

    // MARK: Body
    public var body: some View {
#if os(iOS)
        label()
            .overlay(SwiftUIGestureBaseButtonUIViewRepresentable(
                isEnabled: isEnabled,
                onStateChange: stateChangeHandler
            ))
#elseif canImport(AppKit)
        label()
            .overlay(SwiftUIGestureBaseButtonNSViewRepresentable(
                isEnabled: isEnabled,
                onStateChange: stateChangeHandler
            ))
#endif
    }
}

// MARK: - Preview
@available(tvOS, unavailable)
@available(watchOS, unavailable)
struct SwiftUIGestureBaseButton_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIGestureBaseButton(
            onStateChange: { print($0) },
            label: { Text("Lorem Ipsum") }
        )
    }
}