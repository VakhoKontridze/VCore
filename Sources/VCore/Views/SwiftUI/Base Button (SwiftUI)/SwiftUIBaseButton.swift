//
//  SwiftUIBaseButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.03.23.
//

import SwiftUI

// MARK: - SwiftUI Base Button
/// `SwiftUI` `View` that can be used as a base for all interactive views and buttons.
///
/// `SwiftUIBaseButton` can be used as a basis for all interactive UI components.
///
/// Model:
///
///     struct SomeButtonUIModel {
///         var titleColors: StateColors = .init(
///             enabled: .black,
///             pressed: .gray,
///             disabled: .gray
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
///         private func internalState(_ baseButtonState: SwiftUIBaseButtonState) -> SomeButtonInternalState { baseButtonState }
///         private let action: () -> Void
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
///             SwiftUIBaseButton(
///                 action: action,
///                 label: { baseButtonState in
///                     let internalState: SomeButtonInternalState = internalState(baseButtonState)
///
///                     Text(title)
///                         .foregroundColor(uiModel.titleColors.value(for: internalState))
///                 }
///             )
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
    private let uiModel: SwiftUIBaseButtonUIModel
    private let action: () -> Void
    private let label: (SwiftUIBaseButtonState) -> Label
    
    // MARK: Initializers
    /// Initializes `SwiftUIBaseButtonUIModel` with action and label.
    public init(
        uiModel: SwiftUIBaseButtonUIModel = .init(),
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping (SwiftUIBaseButtonState) -> Label
    ) {
        self.uiModel = uiModel
        self.action = action
        self.label = label
    }
    
    // MARK: Body
    public var body: some View {
        Button(
            action: action,
            label: EmptyView.init
        )
        .buttonStyle(SwiftUIBaseButtonStyle(
            uiModel: uiModel,
            label: label
        ))
    }
}

// MARK: - Preview
struct SwiftUIBaseButton_Previews: PreviewProvider {
    private static var colors: GenericStateModel_EnabledPressedDisabled<Color> {
        .init(
            enabled: .primary,
            pressed: .secondary,
            disabled: .primary
        )
    }
    
    static var previews: some View {
        SwiftUIBaseButton(
            action: { print("Pressed") },
            label: { baseButtonState in
                Text("Lorem Ipsum")
                    .foregroundColor(colors.value(for: baseButtonState))
            }
        )
    }
}
