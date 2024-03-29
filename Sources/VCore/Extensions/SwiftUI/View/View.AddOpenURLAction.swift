//
//  View.AddOpenURLAction.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 30.03.24.
//

import SwiftUI

// MARK: - View Add Open URL Action
extension View {
    /// Inserts `OpenURLAction` in the `Environment`.
    ///
    /// Can be paired with `AttributedString`'s initializer to create a tappable `Text`.
    ///
    ///     @State private var count: Int = 0
    ///
    ///     var body: some View {
    ///         Text(
    ///             AttributedString(
    ///                 stringAndDefault: "Lorem <a>ipsum</a> dolor sit <b>amet</b>: \(count)",
    ///                 attributeContainers: [
    ///                     "a": {
    ///                         var container: AttributeContainer = .init()
    ///                         container.foregroundColor = .green
    ///                         container.font = .body.bold()
    ///                         container.link = #url("a")
    ///                         return container
    ///                     }(),
    ///                     "b": {
    ///                         var container: AttributeContainer = .init()
    ///                         container.foregroundColor = .red
    ///                         container.font = .body.bold()
    ///                         container.link = #url("b")
    ///                         return container
    ///                     }()
    ///                 ]
    ///             )
    ///         )
    ///         .addOpenURLAction({
    ///             switch $0 {
    ///             case #url("a"): count += 1
    ///             case #url("b"): count -= 1
    ///             default: break
    ///             }
    ///         })
    ///         .padding(.horizontal)
    ///      }
    ///
    public func addOpenURLAction(
        _ action: @escaping (URL) -> Void
    ) -> some View {
        self
            .environment(\.openURL, OpenURLAction(handler: { url in
                action(url)
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
            Text(
                AttributedString(
                    stringAndDefault: "Lorem <a>ipsum</a> dolor sit <b>amet</b>: \(count)",
                    attributeContainers: [
                        "a": {
                            var container: AttributeContainer = .init()
                            container.foregroundColor = .green
                            container.font = .body.bold()
                            container.link = #url("a")
                            return container
                        }(),
                        "b": {
                            var container: AttributeContainer = .init()
                            container.foregroundColor = .red
                            container.font = .body.bold()
                            container.link = #url("b")
                            return container
                        }()
                    ]
                )
            )
            .addOpenURLAction({
                switch $0 {
                case #url("a"): count += 1
                case #url("b"): count -= 1
                default: break
                }
            })
            .padding(.horizontal)
         }
    }

    return ContentView()
})

#endif
