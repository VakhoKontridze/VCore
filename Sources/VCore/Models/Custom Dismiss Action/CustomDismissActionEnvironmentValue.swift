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
    ///         Button("Present", action: { isPresented = true })
    ///             .fullScreenCover(
    ///                 isPresented: $isPresented,
    ///                 content: {
    ///                     Destination()
    ///                         .customDismissAction(CustomDismissAction({
    ///                             print("Do something here")
    ///                             isPresented = false
    ///                         }))
    ///                 }
    ///             )
    ///     }
    ///
    ///     struct Destination: View {
    ///         @Environment(\.customDismissAction) private var customDismissAction: CustomDismissAction
    ///
    ///         var body: some View {
    ///             Color.accentColor
    ///                 .ignoresSafeArea()
    ///                 .onTapGesture(perform: { customDismissAction.action() })
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
