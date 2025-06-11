//
//  NavigationStackCoordinator.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.09.23.
//

import SwiftUI

// MARK: - Navigation Stack Coordinator
/// Object that stores `NavigationPath` for coordinating with `CoordinatingNavigationStack`.
///
/// Can be used to push or pop `View`s programmatically.
///
///     var body: some View {
///         CoordinatingNavigationStack {
///             HomeView()
///         }
///     }
///
///     struct HomeView: View {
///         @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator!
///
///         var body: some View {
///             Button("Navigate") {
///                 navigationStackCoordinator.path.append(DestinationParameters())
///             }
///             .inlineNavigationTitle("Home")
///             .navigationDestination(for: DestinationParameters.self, destination: DestinationView.init)
///         }
///     }
///
@Observable
@MainActor
public final class NavigationStackCoordinator: Sendable {
    // MARK: Properties
    /// `NavigationPath`.
    public var path: NavigationPath

    // MARK: Initializers
    /// Initializes `NavigationStackCoordinator`.
    public init(path: NavigationPath) {
        self.path = path
    }
}
