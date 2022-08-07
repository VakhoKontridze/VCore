//
//  AlertPresentable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.08.22.
//

import SwiftUI

// MARK: - Alert Presentable
/// Protocol for presenting an `Alert`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, this protocol is conformed to by a `Presenter`.
/// in `MVVM`, this protocol is conformed to by a `ViewModel.`
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@MainActor public protocol AlertPresentable: ObservableObject {
    /*@Published*/ var alertParameters: AlertParameters? { get set }
}
