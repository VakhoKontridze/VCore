//
//  View + Confirmation Dialog.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.10.22.
//

import SwiftUI

// MARK: - View + Confirmation Dialog
extension View {
    /// Presents `ConfirmationDialog` when `ConfirmationDialogParameters` is non-`nil`.
    ///
    ///     @State private var parameters: ConfirmationDialogParameters?
    ///
    ///     var body: some View {
    ///         Button("Present") {
    ///             parameters = ConfirmationDialogParameters(
    ///                 title: "Lorem Ipsum",
    ///                 message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    ///                 actions: {
    ///                     ConfirmationDialogButton(action: { print("Confirmed") }, title: "Confirm")
    ///                     ConfirmationDialogButton(action: { print("Cancelled") }, title: "Cancel", role: .cancel)
    ///                 }
    ///             )
    ///         }
    ///         .confirmationDialog(parameters: $parameters)
    ///      }
    ///
    public func confirmationDialog(
        parameters: Binding<ConfirmationDialogParameters?>
    ) -> some View {
        self.confirmationDialog(
            parameters.wrappedValue?.title ?? "",
            isPresented: Binding(
                get: { parameters.wrappedValue != nil },
                set: { if !$0 { parameters.wrappedValue = nil } }
            ),
            titleVisibility: {
                switch (parameters.wrappedValue?.title, parameters.wrappedValue?.message) {
                case (nil, nil): .hidden
                case (nil, _?): .visible
                case (_?, nil): .visible
                case (_?, _?): .visible
                }
            }(),
            actions: {
                if let buttons: [any ConfirmationDialogButtonProtocol] = parameters.wrappedValue?.buttons() {
                    // Native `View.alert(...)` doesn't react to changes, so using `offset` as ID is okay
                    ForEach(buttons.enumeratedArray(), id: \.offset) { (_, button) in
                        button.makeBody(animateOutHandler: { completion in
                            completion?()
                        })
                    }
                }
            },
            message: {
                if let message: String = parameters.wrappedValue?.message {
                    Text(message)
                }
            }
        )
    }
}

// MARK: - Preview
#if DEBUG

#Preview {
    @Previewable @State var parameters: ConfirmationDialogParameters?

    Button("Present") {
        parameters = ConfirmationDialogParameters(
            title: "Lorem Ipsum",
            message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
            actions: {
                ConfirmationDialogButton(action: { print("Confirmed") }, title: "Confirm")
                ConfirmationDialogButton(action: { print("Cancelled") }, title: "Cancel", role: .cancel)
            }
        )
    }
    .confirmationDialog(parameters: $parameters)
}

#endif
