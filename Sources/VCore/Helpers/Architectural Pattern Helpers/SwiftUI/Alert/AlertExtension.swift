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
                        button.body(
                            animateOut: {
                                parameters.wrappedValue = nil
                                $0?()
                            }
                        )
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
