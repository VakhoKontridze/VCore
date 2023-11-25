//
//  View.InlineNavigationTitle.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/21/21.
//

import SwiftUI

// MARK: - View Inline Navigation Title
@available(macOS, unavailable)
@available(tvOS, unavailable)
extension View {
    /// Configures the view’s title for purposes of navigation, using a `String` in a inline display mode.
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .inlineNavigationTitle("Home")
    ///     }
    ///
    @ViewBuilder public func inlineNavigationTitle(_ title: String) -> some View {
#if !(os(macOS) || os(tvOS))
        self
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
#endif
    }

    /// Configures the view’s title for purposes of navigation, using a `LocalizedStringKey` in a inline display mode.
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .inlineNavigationTitle("Home")
    ///     }
    ///
    @ViewBuilder public func inlineNavigationTitle(_ titleKey: LocalizedStringKey) -> some View {
#if !(os(macOS) || os(tvOS))
        self
            .navigationTitle(titleKey)
            .navigationBarTitleDisplayMode(.inline)
#endif
    }
}
