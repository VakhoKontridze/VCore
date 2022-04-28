//
//  SwiftUIBaseButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if canImport(BaseButtonTapGestureRecognizer)

import SwiftUI

// MARK: - SwiftUI Base Button
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
///     struct SomeButtonModel {
///         static let titleColor: StateColors = .init(
///             enabled: .black,
///             pressed: .gray,
///             disabled: .gray
///         )
///
///         private init() {}
///
///         typealias StateColors = GenericStateModel_EPD<Color?>
///     }
///
/// State:
///
///     public enum SomeButtonState {
///         case enabled
///         case disabled
///
///         init(internalState: SomeButtonInternalState) {
///             switch internalState {
///             case .enabled: self = .enabled
///             case .pressed: self = .enabled
///             case .disabled: self = .disabled
///             }
///         }
///     }
///
///     enum SomeButtonInternalState {
///         case enabled
///         case pressed
///         case disabled
///
///         var baseButtonState: SwiftUIBaseButtonState {
///             switch self {
///             case .enabled: return .enabled
///             case .pressed: return .enabled
///             case .disabled: return .disabled
///             }
///         }
///
///         init(state: SomeButtonState, isPressed: Bool) {
///             switch (state, isPressed) {
///             case (.enabled, false): self = .enabled
///             case (.enabled, true): self = .pressed
///             case (.disabled, _): self = .disabled
///             }
///         }
///
///         static func `default`(state: SomeButtonState) -> Self {
///             .init(state: state, isPressed: false)
///         }
///     }
///
/// State-Model Mapping:
///
///     extension GenericStateModel_EPD {
///         func `for`(_ state: SomeButtonInternalState) -> Value {
///             switch state {
///             case .enabled: return enabled
///             case .pressed: return pressed
///             case .disabled: return disabled
///             }
///         }
///     }
///
/// Button:
///
///     public struct SomeButton: View {
///         private typealias Model = SomeButtonModel
///
///         private let state: SomeButtonState
///         @State private var internalStateRaw: SomeButtonInternalState?
///         private var internalState: SomeButtonInternalState { internalStateRaw ?? .default(state: state) }
///
///         private let action: () -> Void
///
///         private let title: String
///
///         public init(
///             state: SomeButtonState = .enabled,
///             action: @escaping () -> Void,
///             title: String
///         ) {
///             self.state = state
///             self.action = action
///             self.title = title
///         }
///
///         public var body: some View {
///             syncInternalStateWithState()
///
///             return SwiftUIBaseButton(
///                 state: internalState.baseButtonState,
///                 gesture: gestureHandler,
///                 content: {
///                     Text(title)
///                         .foregroundColor(Model.titleColor.for(internalState))
///                 }
///             )
///         }
///
///         private func syncInternalStateWithState() {
///             DispatchQueue.main.async(execute: {
///                 if
///                     internalStateRaw == nil ||
///                     .init(internalState: internalState) != state
///                 {
///                     internalStateRaw = .default(state: state)
///                 }
///             })
///         }
///
///         private func gestureHandler(gestureState: BaseButtonGestureState) {
///             internalStateRaw = .init(state: state, isPressed: gestureState.isPressed)
///             if gestureState.isClicked { action() }
///         }
///     }
///
/// Usage Example:
///
///     var body: some View {
///         SomeButton(
///             action: { print("Clicked") },
///             title: "Lorem Ipsum"
///         )
///     }
///
public struct SwiftUIBaseButton<Content>: View where Content: View {
    // MARK: Properties
    private let state: SwiftUIBaseButtonState
    
    private var gestureHandler: (BaseButtonGestureState) -> Void
    
    private let content: () -> Content
    
    // MARK: Initializers - State
    /// Initializes component with state, gesture handler, and content.
    public init(
        state: SwiftUIBaseButtonState,
        gesture gestureHandler: @escaping (BaseButtonGestureState) -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.state = state
        self.gestureHandler = gestureHandler
        self.content = content
    }
    
    /// Initializes component with state, action, and content.
    public init(
        state: SwiftUIBaseButtonState,
        action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.state = state
        self.gestureHandler = { gestureState in if gestureState.isClicked { action() } }
        self.content = content
    }
    
    // MARK: Initializers - Bool
    /// Initializes component with bool, gesture handler, and content.
    public init(
        isEnabled: Bool,
        gesture gestureHandler: @escaping (BaseButtonGestureState) -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.state = .init(isEnabled: isEnabled)
        self.gestureHandler = gestureHandler
        self.content = content
    }
    
    /// Initializes component with bool, action, and content.
    public init(
        isEnabled: Bool,
        action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.state = .init(isEnabled: isEnabled)
        self.gestureHandler = { gestureState in if gestureState.isClicked { action() } }
        self.content = content
    }

    // MARK: Body
    public var body: some View {
        content()
            .overlay(SwiftUIBaseButtonViewRepresentable(
                isEnabled: state.isEnabled,
                gesture: gestureHandler
            ))
    }
}

// MARK: - Preview
struct SwiftUIBaseButton_Previews: PreviewProvider {
    @State private static var state: SwiftUIBaseButtonState = .enabled
    
    static var previews: some View {
        SwiftUIBaseButton(
            state: state,
            gesture: { gestureState in
                switch gestureState {
                case .none: print("-")
                case .press: print("Pressing")
                case .click: print("Clicked")
                }
            },
            content: { Text("Lorem ipsum") }
        )
    }
}

#endif
