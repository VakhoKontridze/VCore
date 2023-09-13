//
//  ViewResettingContainer.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.02.23.
//

import SwiftUI

// MARK: - View Resetting Container
/// `View` that resets content on demand.
///
/// Can be used to trigger reload on an app level.
/// `SwiftUI`'s equivalent of replacing `rootViewController` in `UIKit`
///
/// In the following example, scrolling down and triggering reset causes app's content to be reset.
///
///     @main struct SomeApp: App {
///         var body: some Scene {
///             WindowGroup(content: {
///                 ViewResettingContainer(content: {
///                     ContentView()
///                 })
///             })
///         }
///     }
///
///     struct ContentView: View {
///         @EnvironmentObject private var viewResetter: ViewResetter
///
///         var body: some View {
///             ScrollView(content: {
///                 Color.red
///                     .frame(height: UIScreen.main.bounds.size.height)
///
///                 Button(
///                     "Reset",
///                     action: { viewResetter.trigger() }
///                 )
///             })
///         }
///     }
///
public struct ViewResettingContainer<Content>: View where Content: View {
    // MARK: Properties
    @StateObject private var viewResetter: ViewResetter = .init()
    private let content: (ViewResetter) -> Content
    
    // MARK: Initializers
    /// Initializers `ViewResettingContainer` with content.
    public init(
        @ViewBuilder content: @escaping (ViewResetter) -> Content
    ) {
        self.content = content
    }
    
    /// Initializers `ViewResettingContainer` with content.
    public init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = { _ in content() }
    }
    
    // MARK: Body
    public var body: some View {
        Group(content: {
            if viewResetter.value.isMultiple(of: 2) {
                content(viewResetter)
            } else {
                content(viewResetter)
            }
        })
        .environmentObject(viewResetter)
    }
}
