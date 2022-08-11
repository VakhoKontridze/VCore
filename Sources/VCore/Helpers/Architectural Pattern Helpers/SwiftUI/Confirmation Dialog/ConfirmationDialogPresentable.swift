//
//  ConfirmationDialogPresentable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.08.22.
//

import SwiftUI

// MARK: - Confirmation Dialog Presentable
/// Protocol for presenting an `ConfirmationDialog`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, this protocol is conformed to by a `Presenter`.
/// in `MVVM` architecture, this protocol is conformed to by a `ViewModel.`
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@MainActor public protocol ConfirmationDialogPresentable: ObservableObject {
    /// Confirmation dialog parameters.
    /*@Published*/ var confirmationDialogParameters: ConfirmationDialogParameters? { get set }
}
