//
//  ViewResettingContainer.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.09.23.
//

import SwiftUI

// MARK: - View Resetting Container
/// `View` that resets content on demand.
///
/// Can be used to trigger reload on an app level.
/// `SwiftUI`'s equivalent of replacing `rootViewController` in `UIKit`
///
/// In the following example, scrolling down and triggering reset causes content to be reset.
///
///     var body: some View {
///         ViewResettingContainer {
///             ChildView()
///         }
///     }
///
///     struct ChildView: View {
///         @Environment(\.viewResetter) private var viewResetter: ViewResetter!
///
///         var body: some View {
///             ScrollView {
///                 Color.accentColor
///                     .frame(height: UIScreen.main.bounds.size.height)
///
///                 Button(
///                     "Reset",
///                     action: viewResetter.trigger
///                 )
///             }
///         }
///     }
///
public struct ViewResettingContainer<Content>: View where Content: View {
    // MARK: Properties
    @State private var viewResetter: ViewResetter = .init()
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
        Group {
            if viewResetter.value.isMultiple(of: 2) {
                content(viewResetter)
            } else {
                content(viewResetter)
            }
        }
        .environment(\.viewResetter, viewResetter)
    }
}

// MARK: - Preview
#if DEBUG

#Preview {
    struct ContentView: View {
        var body: some View {
            ViewResettingContainer {
                ChildView()
            }
        }
    }

    struct ChildView: View {
        @Environment(\.viewResetter) private var viewResetter: ViewResetter!

        var body: some View {
            GeometryReader { geometryProxy in
                ScrollView {
                    Color.accentColor
                        .frame(height: geometryProxy.size.height * 1.2)

                    Button(
                        "Reset",
                        action: viewResetter.trigger
                    )
                }
            }
        }
    }

    return ContentView()
}

#endif
