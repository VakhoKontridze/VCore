//
//  NavigationStackCoordinatorOO.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.08.22.
//

import SwiftUI

// MARK: - Navigation Stack Coordinator (Observable Object)
/// Object that stores `NavigationPath` for coordinating with `CoordinatingNavigationStackOO`.
///
/// Can be used to push or pop `View`s programmatically.
///
///     var body: some View {
///         CoordinatingNavigationStackOO(root: {
///             HomeView()
///         })
///     }
///
///     struct HomeView: View {
///         @Environment(\.navigationStackCoordinatorOO) private var navigationStackCoordinator: NavigationStackCoordinatorOO!
///
///         var body: some View {
///             Button(
///                 "Navigate",
///                 action: { navigationStackCoordinator.path.append(DestinationParameters()) }
///             )
///             .navigationDestination(for: DestinationParameters.self, destination: DestinationView.init)
///         }
///     }
///
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public final class NavigationStackCoordinatorOO: ObservableObject {
    // MARK: Properties
    /// `NavigationPath`.
    @Published public var path: NavigationPath
    
    // MARK: Initializers
    /// Initializes `NavigationStackCoordinatorOO`.
    public init(path: NavigationPath) {
        self.path = path
    }
}
