//
//  SwiftUIGestureBaseButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

import SwiftUI

// MARK: - Swift UI Gesture Base Button
/// `SwiftUI` `View` that can be used as a base for all interactive views and buttons.
///
/// `SwiftUIGestureBaseButton` can be used as a basis for all interactive UI components.
///
/// Model:
///
///     struct SomeButtonUIModel {
///         var titleColors: StateColors = .init(
///             enabled: Color.primary,
///             pressed: Color.secondary,
///             disabled: Color.secondary
///         )
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
///                         .foregroundStyle(uiModel.titleColors.value(for: internalState))
///                 }
///             )
///             .disabled(internalState == .disabled)
///         }
///
///         private func stateChangeHandler(gestureState: GestureBaseButtonGestureState) {
///             isPressed = gestureState.didRecognizePress
///             if gestureState.didRecognizeClick { action() }
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
@available(tvOS, unavailable) // No `UIKitBaseButtonGestureRecognizer`
@available(watchOS, unavailable) // No `UIKitBaseButtonGestureRecognizer`
public struct SwiftUIGestureBaseButton<Label>: View where Label: View {
    // MARK: Properties
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    private var stateChangeHandler: (GestureBaseButtonGestureState) -> Void
    
    private let label: () -> Label
    
    // MARK: Initializers
    /// Initializes `SwiftUIGestureBaseButton` with state change handler and label.
    public init(
        onStateChange stateChangeHandler: @escaping (GestureBaseButtonGestureState) -> Void,
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
            if gestureState.didRecognizeClick { action() }
        }
        self.label = label
    }
    
    // MARK: Body
    public var body: some View {
#if canImport(UIKit) && !os(watchOS)
        label()
            .overlay {
                SwiftUIGestureBaseButton_UIKit(
                    isEnabled: isEnabled,
                    onStateChange: stateChangeHandler
                )
            }
#elseif canImport(AppKit)
        label()
            .overlay {
                SwiftUIGestureBaseButton_AppKit(
                    isEnabled: isEnabled,
                    onStateChange: stateChangeHandler
                )
            }
#endif
    }
}

// MARK: - Preview
#if DEBUG

#if !(os(tvOS) || os(watchOS)) // Redundant

#Preview {
    @Previewable @State var isPressed: Bool = false

    SwiftUIGestureBaseButton(
        onStateChange: { state in
            isPressed = state.didRecognizePress
        },
        label: {
            Text("Lorem Ipsum")
                .opacity(isPressed ? 0.3 : 1)
        }
    )
}

#endif

#endif
