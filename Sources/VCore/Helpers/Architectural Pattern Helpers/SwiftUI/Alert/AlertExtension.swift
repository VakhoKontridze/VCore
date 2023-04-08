//
//  AlertExtension.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.10.22.
//

import SwiftUI

// MARK: - Alert Extension
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension View {
    /// Presents `Alert` when `AlertParameters` is non-`nil`.
    ///
    ///     @State private var parameters: AlertParameters? = .init(
    ///         title: "Lorem Ipsum",
    ///         message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    ///         actions: {
    ///             AlertButton(action: { print("Confirmed") }, title: "Confirm")
    ///             AlertButton(role: .cancel, action: { print("Cancelled") }, title: "Cancel")
    ///         }
    ///     )
    ///
    ///     var body: some View {
    ///         content
    ///             .alert(parameters: $parameters)
    ///     }
    ///
    @ViewBuilder public func alert(
        parameters: Binding<AlertParameters?>
    ) -> some View {
        switch parameters.wrappedValue {
        case nil:
            self
            
        case let _parameters?:
            self.alert(
                _parameters.title,
                isPresented: .constant(true),
                actions: {
                    ForEach(_parameters.buttons().enumeratedArray(), id: \.offset, content: { (_, button) in
                        button.makeBody(animateOut: { completion in
                            parameters.wrappedValue = nil
                            completion?()
                        })
                    })
                },
                message: {
                    if let message: String = _parameters.message {
                        Text(message)
                    }
                }
            )
        }
    }
}
