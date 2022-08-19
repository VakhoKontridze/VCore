//
//  NavigationStackCoordinable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.08.22.
//

import SwiftUI

// MARK: - Navigation Stack Coordinable
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
/// Protocol for managing `NavigationPath` within `NavigationStackCoordinator`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, this protocol is conformed to by a `Presenter`.
/// in `MVVM` architecture, this protocol is conformed to by a `ViewModel.`
///
///     @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator?
///     @StateObject private var presenter: Presenter
///     @State private var didAppearForTheFirstTime: Bool = false
///
///     var body: some View {
///         content
///             .onFirstAppear(didAppear: $didAppearForTheFirstTime, perform: {
///                 presenter.navigationStackCoordinator = navigationStackCoordinator
///             })
///             
@MainActor public protocol NavigationStackCoordinable: ObservableObject {
    /// Navigation stack coordinator.
    var navigationStackCoordinator: NavigationStackCoordinator? { get set }
}
