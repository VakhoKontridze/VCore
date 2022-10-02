//
//  ConfirmationDialogExtension.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.10.22.
//

import SwiftUI

// MARK: - Confirmation Dialog Extension
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension View {
    /// Presents `ConfirmationDialog` when `ConfirmationDialogParameters` is non-`nil`.
    @ViewBuilder public func confirmationDialog(
        parameters: Binding<ConfirmationDialogParameters?>
    ) -> some View {
        switch parameters.wrappedValue {
        case nil:
            self

        case let _parameters?:
            self.confirmationDialog(
                _parameters.title ?? "",
                isPresented: .constant(true),
                titleVisibility: .confirmationDialog(title: _parameters.title, message: _parameters.message),
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

// MARK: - Helpers
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension Visibility {
    fileprivate static func confirmationDialog(title: String?, message: String?) -> Self {
        switch (title, message) {
        case (nil, nil): return .hidden
        case (nil, _?): return .visible
        case (_?, nil): return .visible
        case (_?, _?): return .visible
        }
    }
}
