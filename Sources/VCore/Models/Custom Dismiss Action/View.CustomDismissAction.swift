//
//  View.CustomDismissAction.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14.04.23.
//

import SwiftUI

// MARK: - View Custom Dismiss Action
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
