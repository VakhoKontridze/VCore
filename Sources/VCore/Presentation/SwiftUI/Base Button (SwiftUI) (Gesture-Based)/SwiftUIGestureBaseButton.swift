//
//  SwiftUIGestureBaseButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

import SwiftUI

/// `SwiftUI` `View` that can be used as a base for all interactive views and buttons.
///
/// `SwiftUIGestureBaseButton` can be used as a basis for all interactive UI components.
///
/// Appearance:
///
///     struct PlainButtonAppearance {
///         var labelTextColors: StateColors = .init(
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
///     typealias PlainButtonInternalState = GenericState_EnabledPressedDisabled
///
/// Button:
///
///     struct PlainButton: View {
///         private let appearance: PlainButtonAppearance
///
///         @Environment(\.isEnabled) private var isEnabled: Bool
///         @State private var isPressed: Bool = false
///         private var internalState: PlainButtonInternalState { .init(isEnabled: isEnabled, isPressed: isPressed) }
///
///         private let action: () -> Void
///
///         private let title: String
///
///         init(
///             appearance: PlainButtonAppearance = .init(),
///             action: @escaping () -> Void,
///             title: String
///         ) {
///             self.appearance = appearance
///             self.action = action
///             self.title = title
///         }
///
///         var body: some View {
///             SwiftUIGestureBaseButton(
///                 onStateChange: onStateChange,
///                 label: {
///                     Text(title)
///                         .foregroundStyle(appearance.labelTextColors.value(for: internalState))
///                 }
///             )
///             .disabled(internalState == .disabled)
///         }
///
///         private func onStateChange(gestureState: GestureBaseButtonGestureState) {
///             isPressed = gestureState.didRecognizePress
///             if gestureState.didRecognizeClick { action() }
///         }
///     }
///
///     var body: some View {
///         PlainButton(
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
    
    private var onStateChange: (GestureBaseButtonGestureState) -> Void
    
    private let label: () -> Label
    
    // MARK: Initializers
    /// Initializes `SwiftUIGestureBaseButton` with state change action and label.
    public init(
        onStateChange: @escaping (GestureBaseButtonGestureState) -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.onStateChange = onStateChange
        self.label = label
    }
    
    /// Initializes `SwiftUIGestureBaseButton` with action and label.
    public init(
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.onStateChange = { gestureState in
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
                    onStateChange: onStateChange
                )
            }
#elseif canImport(AppKit)
        label()
            .overlay {
                SwiftUIGestureBaseButton_AppKit(
                    isEnabled: isEnabled,
                    onStateChange: onStateChange
                )
            }
#endif
    }
}

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
