//
//  CustomDismissActionEnvironmentValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14.04.23.
//

import SwiftUI

// MARK: - Custom Dismiss Action Extension
extension View {
    /// Sets the environment value of `CustomDismissAction` to the given value.
    ///
    ///     @State private var isPresented: Bool = false
    ///
    ///     var body: some View {
    ///         Button(
    ///             "Present",
    ///             action: { isPresented = true }
    ///         )
    ///         .sheet(
    ///             isPresented: $isPresented,
    ///             content: {
    ///                 DestinationView()
    ///                     .customDismissAction(CustomDismissAction({
    ///                         print("Do something here")
    ///                         isPresented = false
    ///                     }))
    ///             }
    ///         )
    ///     }
    ///
    ///     struct DestinationView: View {
    ///         @Environment(\.customDismissAction) private var customDismissAction: CustomDismissAction
    ///
    ///         var body: some View {
    ///             Color.accentColor
    ///                 .ignoresSafeArea()
    ///                 .onTapGesture(perform: customDismissAction.action)
    ///         }
    ///     }
    ///
    public func customDismissAction(
        _ customDismissAction: CustomDismissAction
    ) -> some View {
        self
            .environment(\.customDismissAction, customDismissAction)
    }
}

// MARK: - Custom Dismiss Action Environment Value
extension EnvironmentValues {
    /// Custom action that dismisses a presentation.
    public var customDismissAction: CustomDismissAction {
        get { self[CustomDismissActionEnvironmentKey.self] }
        set { self[CustomDismissActionEnvironmentKey.self] = newValue }
    }
}

// MARK: - Custom Dismiss Action Environment Key
struct CustomDismissActionEnvironmentKey: EnvironmentKey {
    static let defaultValue: CustomDismissAction = .init()
}

// MARK: - Preview
#if DEBUG

#Preview(body: {
    guard #available(tvOS 16.0, *) else { return EmptyView() }

    struct ContentView: View {
        @State private var isPresented: Bool = false
        @State private var dismissCount: Int = 0

        var body: some View {
            Button(
                "Present \(dismissCount)",
                action: { isPresented = true }
            )
            .sheet(
                isPresented: $isPresented,
                content: {
                    DestinationView()
                        .customDismissAction(CustomDismissAction({
                            dismissCount += 1
                            isPresented = false
                        }))
                }
            )
        }
    }

    struct DestinationView: View {
        @Environment(\.customDismissAction) private var customDismissAction: CustomDismissAction

        var body: some View {
            Color.accentColor
                .ignoresSafeArea()
                .onTapGesture(perform: customDismissAction.action)
        }
    }

    return ContentView()
})

#endif
