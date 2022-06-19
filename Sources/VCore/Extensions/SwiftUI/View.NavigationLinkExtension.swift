//
//  View.NavigationLinkExtension.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI

// MARK: - View Navigation Link Extension
extension View {
    /// Allows for navigation without an explicit `NavigationLink`.
    ///
    ///     @State var isActive: Bool = false
    ///
    ///     var body: some View {
    ///         NavigationView(content: {
    ///             ZStack(content: {
    ///                 ColorBook.canvas.ignoresSafeArea()
    ///
    ///                 Button(
    ///                     action: { isActive = true },
    ///                     title: "Lorem Ipsum"
    ///                 )
    ///             })
    ///                 .navigationTitle("Home")
    ///                 .navigationBarTitleDisplayMode(.inline)
    ///                 .navigationLink(isActive: $isActive, destination: { destination })
    ///         })
    ///     }
    ///
    ///     var destination: some View {
    ///         Color.white.ignoresSafeArea()
    ///            .standardNavigationTitle("Destination")
    ///     }
    ///
    public func navigationLink<Destination>(
        isActive: Binding<Bool>,
        @ViewBuilder destination: @escaping () -> Destination
    ) -> some View
        where Destination: View
    {
        self
            .background(
                NavigationLink(
                    isActive: isActive,
                    destination: destination,
                    label: { EmptyView() }
                )
                    .allowsHitTesting(false)
                    .opacity(0)
            )
    }
}
