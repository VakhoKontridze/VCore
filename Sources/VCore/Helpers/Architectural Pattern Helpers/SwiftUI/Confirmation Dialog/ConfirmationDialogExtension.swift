//
//  ConfirmationDialogExtension.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.10.22.
//

import SwiftUI

// MARK: - Confirmation Dialog Extension
extension View {
    /// Presents `ConfirmationDialog` when `ConfirmationDialogParameters` is non-`nil`.
    ///
    ///     @State private var parameters: ConfirmationDialogParameters?
    ///
    ///     var body: some View {
    ///         Button(
    ///             "Present",
    ///             action: {
    ///                 parameters = ConfirmationDialogParameters(
    ///                     title: "Lorem Ipsum",
    ///                     message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    ///                     actions: {
    ///                         ConfirmationDialogButton(action: { print("Confirmed") }, title: "Confirm")
    ///                         ConfirmationDialogButton(role: .cancel, action: { print("Cancelled") }, title: "Cancel")
    ///                     }
    ///                 )
    ///             }
    ///         )
    ///         .confirmationDialog(parameters: $parameters)
    ///  
    public func confirmationDialog(
        parameters: Binding<ConfirmationDialogParameters?>
    ) -> some View {
        self.confirmationDialog(
            parameters.wrappedValue?.title ?? "",
            isPresented: Binding(
                get: { parameters.wrappedValue != nil },
                set: { if $0 { parameters.wrappedValue = nil } }
            ),
            titleVisibility: Visibility.confirmationDialog(
                title: parameters.wrappedValue?.title,
                message: parameters.wrappedValue?.message
            ),
            actions: {
                if let buttons: [any ConfirmationDialogButtonProtocol] = parameters.wrappedValue?.buttons() {
                    ForEach(
                        buttons.enumeratedArray(),
                        id: \.offset,
                        content: { (_, button) in
                            button.makeBody(animateOut: { completion in
                                parameters.wrappedValue = nil
                                completion?()
                            })
                        }
                    )
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

// MARK: - Helpers
extension Visibility {
    fileprivate static func confirmationDialog(
        title: String?,
        message: String?
    ) -> Self {
        switch (title, message) {
        case (nil, nil): return .hidden
        case (nil, _?): return .visible
        case (_?, nil): return .visible
        case (_?, _?): return .visible
        }
    }
}
