//
//  View.OnOpenURLExplicit.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 30.03.24.
//

import SwiftUI

// MARK: - View on Open URL Explicit
extension View {
    /// Registers a handler to invoke in response to a specific `URL` that was received.
    ///
    /// Can be paired with `AttributedString`'s initializers to create a tappable `Text`.
    ///
    ///     @State private var count: Int = 0
    ///
    ///     var body: some View {
    ///         VStack(content: {
    ///             Text(
    ///                 AttributedString(
    ///                     stringAndDefault: "Lorem ipsum dolor sit <c>amet</c>.",
    ///                     attributeContainers: [
    ///                         "c": {
    ///                             var container: AttributeContainer = .init()
    ///                             container.font = .body.bold()
    ///                             container.link = #url("c")
    ///                             return container
    ///                         }()
    ///                     ]
    ///                 )
    ///              )
    ///              .onOpenURL(#url("c"), perform: { count += 1 })
    ///
    ///              Text("\(count)")
    ///          })
    ///          .padding(.horizontal)
    ///      }
    ///
    public func onOpenURL(
        _ url: URL,
        perform action: @escaping () -> Void
    ) -> some View {
        self
            .environment(\.openURL, OpenURLAction(handler: { openedURL in
                guard url == openedURL else { return .discarded }

                action()
                return .handled
            }))
    }
}

// MARK: - Preview
#if DEBUG

#Preview(body: {
    struct ContentView: View {
        @State private var count: Int = 0

        var body: some View {
            VStack(content: {
                Text(
                    AttributedString(
                        stringAndDefault: "Lorem ipsum dolor sit <c>amet</c>.",
                        attributeContainers: [
                            "c": {
                                var container: AttributeContainer = .init()
                                container.font = .body.bold()
                                container.link = #url("c")
                                return container
                            }()
                        ]
                    )
                )
                .onOpenURL(#url("c"), perform: { count += 1 })

                Text("\(count)")
            })
            .padding(.horizontal)
        }
    }

    return ContentView()
})

#endif
