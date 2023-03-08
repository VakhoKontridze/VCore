//
//  View.InlineNavigationTitle.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/21/21.
//

#if os(iOS)

import SwiftUI

// MARK: - View Inline Navigation Title
extension View {
    /// Configures the view’s title for purposes of navigation, using a `String` in a inline display mode.
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .inlineNavigationTitle("Home")
    ///     }
    ///
    @ViewBuilder public func inlineNavigationTitle(_ title: String) -> some View {
        if #available(iOS 14.0, *) {
            self
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
        
        } else {
            self
                .navigationBarTitle(title)
        }
    }
}

#endif
