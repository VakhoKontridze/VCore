//
//  SwiftUIBaseButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.03.23.
//

import SwiftUI

// MARK: - Swift UI Base Button
/// `SwiftUI` `View` that can be used as a base for all interactive views and buttons.
///
/// `SwiftUIBaseButton` can be used as a basis for all interactive UI components.
///
/// Model:
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
///         private func internalState(_ baseButtonState: SwiftUIBaseButtonState) -> PlainButtonInternalState { baseButtonState }
///         private let action: () -> Void
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
///             SwiftUIBaseButton(
///                 action: action,
///                 label: { baseButtonState in
///                     let internalState: PlainButtonInternalState = internalState(baseButtonState)
///
///                     Text(title)
///                         .foregroundStyle(appearance.labelTextColors.value(for: internalState))
///                 }
///             )
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
public struct SwiftUIBaseButton<Label>: View where Label: View {
    // MARK: Properties
    private let appearance: SwiftUIBaseButtonAppearance
    private let action: () -> Void
    private let label: (SwiftUIBaseButtonState) -> Label
    
    // MARK: Initializers
    /// Initializes `SwiftUIBaseButtonAppearance` with action and label.
    public init(
        appearance: SwiftUIBaseButtonAppearance = .init(),
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping (SwiftUIBaseButtonState) -> Label
    ) {
        self.appearance = appearance
        self.action = action
        self.label = label
    }
    
    // MARK: Body
    public var body: some View {
        Button(
            action: action,
            label: EmptyView.init
        )
        .buttonStyle(
            SwiftUIBaseButtonStyle(
                appearance: appearance,
                label: label
            )
        )
    }
}

// MARK: - Preview
#if DEBUG

#Preview {
    ContentView()
}

// Macros aren't allowed in Preview macro
private struct ContentView: View {
    let colors: GenericStateModel_EnabledPressedDisabled<Color> = .init(
        enabled: Color.primary,
        pressed: Color.secondary,
        disabled: Color.secondary
    )

    var body: some View {
        SwiftUIBaseButton(
            action: {},
            label: { baseButtonState in
                Text("Lorem Ipsum")
                    .foregroundStyle(colors.value(for: baseButtonState))
            }
        )
    }
}

#endif
