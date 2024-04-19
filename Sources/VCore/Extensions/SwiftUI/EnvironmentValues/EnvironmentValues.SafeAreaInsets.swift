//
//  EnvironmentValues.SafeAreaInsets.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.08.23.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

// MARK: - Environment Values Safe Area Insets
extension EnvironmentValues {
    /// Safe are insets of the view in `UIApplication.shared.firstWindowInSingleSceneApp`.
    ///
    ///     @Environment(\.safeAreaInsets) var safeAreaInsets: EdgeInsets
    ///
    ///     var body: some View {
    ///         ZStack(content: {
    ///             Color.red
    ///
    ///             Color.blue
    ///                 .padding(safeAreaInsets)
    ///         })
    ///         .ignoresSafeArea()
    ///     }
    ///
    public var safeAreaInsets: EdgeInsets {
        guard
            let window: UIWindow = UIApplication.shared.firstWindowInSingleSceneApp
        else {
            return EdgeInsets()
        }

        let safeAreaInsets: UIEdgeInsets = window.safeAreaInsets

        return EdgeInsets(
            top: safeAreaInsets.top,
            leading: safeAreaInsets.left,
            bottom: safeAreaInsets.bottom,
            trailing: safeAreaInsets.right
        )
    }
}

// MARK: - Preview
#if DEBUG

#Preview(body: {
    struct ContentView: View {
        @Environment(\.safeAreaInsets) var safeAreaInsets: EdgeInsets

        var body: some View {
            ZStack(content: {
                Color.red

                Color.blue
                    .padding(safeAreaInsets)
            })
            .ignoresSafeArea()
        }
    }

    return ContentView()
})

#endif

#endif
