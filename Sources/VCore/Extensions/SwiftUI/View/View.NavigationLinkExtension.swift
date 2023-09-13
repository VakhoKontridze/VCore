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
    ///     @State private var isActive: Bool = false
    ///
    ///     var body: some View {
    ///         NavigationView(content: {
    ///             ZStack(content: {
    ///                 Color(uiColor: .secondaryBackground).ignoresSafeArea()
    ///
    ///                 Button(
    ///                     action: { isActive = true },
    ///                     title: "Lorem Ipsum"
    ///                 )
    ///             })
    ///             .navigationTitle("Home")
    ///             .navigationBarTitleDisplayMode(.inline)
    ///             .navigationLink(isActive: $isActive, destination: { destination })
    ///         })
    ///     }
    ///
    ///     private var destination: some View {
    ///         Color(uiColor: .systemBackground)
    ///             .ignoresSafeArea()
    ///             .inlineNavigationTitle("Destination")
    ///     }
    ///
    public func navigationLink(
        isActive: Binding<Bool>,
        @ViewBuilder destination: @escaping () -> some View
    ) -> some View {
        self
            .background(content: {
                NavigationLink(
                    isActive: isActive,
                    destination: destination,
                    label: { EmptyView() }
                )
                .allowsHitTesting(false)
                .opacity(0)
            })
    }
}
