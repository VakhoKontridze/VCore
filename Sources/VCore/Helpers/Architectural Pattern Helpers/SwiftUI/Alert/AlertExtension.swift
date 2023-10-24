//
//  AlertExtension.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.10.22.
//

import SwiftUI

// MARK: - Alert Extension
extension View {
    /// Presents `Alert` when `AlertParameters` is non-`nil`.
    ///
    ///     @State private var parameters: AlertParameters?
    ///
    ///     var body: some View {
    ///         Button(
    ///             "Present",
    ///             action: {
    ///                 parameters = (
    ///                     title: "Lorem Ipsum",
    ///                     message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    ///                     actions: {
    ///                         AlertButton(action: { print("Confirmed") }, title: "Confirm")
    ///                         AlertButton(role: .cancel, action: { print("Cancelled") }, title: "Cancel")
    ///                     }
    ///                 )
    ///             }
    ///         )
    ///         .alert(parameters: $parameters)
    ///     }
    ///
    public func alert(
        parameters: Binding<AlertParameters?>
    ) -> some View {
        self.alert(
            parameters.wrappedValue?.title ?? "",
            isPresented: Binding(
                get: { parameters.wrappedValue != nil },
                set: { if $0 { parameters.wrappedValue = nil } }
            ),
            actions: {
                if let buttons: [any AlertButtonProtocol] = parameters.wrappedValue?.buttons() {
                    ForEach(
                        buttons,
                        id: \.id, // Despite identification, native `View.alert(...)` doesn't react to changes
                        content: { button in
                            button.makeBody(animateOutHandler: { completion in
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
