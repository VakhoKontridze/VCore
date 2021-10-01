//
//  SceneRouting.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/21/21.
//

import SwiftUI

// MARK: - Routing
extension View {
    /// Alows SwiftUI `View` to route based on a current value of enumeration.
    ///
    /// Used in `VIPER` architecture. `Presenter` should contain a variable that represents all possible routes.
    /// Then, `View` should contain one modiifer for each case, representing a navigation.
    ///
    /// Usage Example:
    ///
    ///     .route(
    ///         $presenter.route,
    ///         route: .something,
    ///         destination: presenter.router.somethingSceneBody
    ///     )
    ///
    @ViewBuilder public func route<SceneEnumeration, Destination>(
        _ enumeration: Binding<SceneEnumeration?>,
        route: SceneEnumeration,
        destination: Destination
    ) -> some View
        where
            SceneEnumeration: Equatable & Hashable,
            Destination: View
    {
        self
            .background(
                NavigationLink(
                    destination: destination,
                    isActive: .init(
                        get: { enumeration.wrappedValue == route },
                        set: { enumeration.wrappedValue = $0 ? route : nil }
                    ),
                    label: { EmptyView() }
                )
                    .allowsHitTesting(false)
                    .opacity(0)
            )
    }
}
