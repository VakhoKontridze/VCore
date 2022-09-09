//
//  NavigationStackCoordinator.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.08.22.
//

import SwiftUI

// MARK: - Navigation Stack Coordinator
/// `ObservableObject` that stores `NavigationPath` for coordinating with `CoordinatingNavigationStack`.
///
/// Can be used to push or pop `View`s from `Presenter` or `ViewModel`.
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
