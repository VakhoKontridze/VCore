//
//  ViewResettingContainerOO.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.02.23.
//

import SwiftUI

// MARK: - View Resetting Container (Observable Object)
/// `View` that resets content on demand.
///
/// Can be used to trigger reload on an app level.
/// `SwiftUI`'s equivalent of replacing `rootViewController` in `UIKit`
///
/// In the following example, scrolling down and triggering reset causes content to be reset.
///
///     var body: some View {
///         ViewResettingContainerOO(content: {
///             ContentView()
///         })
///     }
///
///     struct ContentView: View {
///         @Environment(\.viewResetterOO) private var viewResetter: ViewResetterOO!
///
///         var body: some View {
///             ScrollView(content: {
///                 Color.accentColor
///                     .frame(height: UIScreen.main.bounds.size.height)
///
///                 Button(
///                     "Reset",
///                     action: viewResetter.trigger
///                 )
///             })
///         }
///     }
///
public struct ViewResettingContainerOO<Content>: View where Content: View { // TODO: iOS 17.0 - Remove, as it's obsoleted
    // MARK: Properties
    @StateObject private var viewResetter: ViewResetterOO = .init()
    private let content: (ViewResetterOO) -> Content
    
    // MARK: Initializers
    /// Initializers `ViewResettingContainerOO` with content.
    public init(
        @ViewBuilder content: @escaping (ViewResetterOO) -> Content
    ) {
        self.content = content
    }
    
    /// Initializers `ViewResettingContainerOO` with content.
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
        .viewResetterOO(viewResetter)
    }
}
