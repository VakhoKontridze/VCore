//
//  NavigationStackCoordinator.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.08.22.
//

import SwiftUI

// MARK: - Navigation Stack Coordinator
/// Object that stores `NavigationPath` for coordinating with `CoordinatingNavigationStack`.
///
/// Can be used to push or pop `View`s programmatically.
///
///     @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator!
///
///     var body: some View {
///         CoordinatingNavigationStack(root: {
///             Button(
///                 "Lorem ipsum",
///                 action: { navigationStackCoordinator.path.append(DestinationParameters()) }
///             )
///             .navigationDestination(
///                 for: DestinationParameters.self,
///                 destination: { DestinationView(parameters: $0) }
///             )
///         })
///     }
///
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public final class NavigationStackCoordinator: ObservableObject {
    // MARK: Properties
    /// `NavigationPath`.
    @Published public var path: NavigationPath
    
    // MARK: Initializers
    /// Initializes `NavigationStackCoordinator`.
    public init(path: NavigationPath) {
        self.path = path
    }
}
