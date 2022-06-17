//
//  View.StandardNavigationTitle.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/21/21.
//

#if os(iOS)

import SwiftUI

// MARK: - Extension
extension View {
    /// Configures the view’s title for purposes of navigation, using a `String` in a inline display mode.
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .standardNavigationTitle("Home")
    ///     }
    ///
    public func standardNavigationTitle(_ title: String) -> some View {
        self
            .modifier(StandardNavigationTitle(title))
    }
}

// MARK: - Standard Navigation Title View Modifier
private struct StandardNavigationTitle: ViewModifier {
    // MARK: Properties
    private let title: String
    
    // MARK: Initializers
    init(_ title: String) {
        self.title = title
    }

    // MARK: Body
    func body(content: Content) -> some View {
        if #available(iOS 14.0, *) {
            content
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
        
        } else {
            content
                .navigationBarTitle(title)
        }
    }
}

#endif
