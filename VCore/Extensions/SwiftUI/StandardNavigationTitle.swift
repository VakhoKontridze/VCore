//
//  StandardNavigationTitle.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/21/21.
//

import SwiftUI

// MARK: - Extension
extension View {
    /// Configures the view’s title for purposes of navigation, using a string in a inline display mode.
    @available(iOS 14, *)
    public func standardNavigationTitle(_ title: String) -> some View {
        self
            .modifier(StandardNavigationTitle(title))
    }
}

// MARK: - Standard Navigation Title View Modifier
@available(iOS 14, *)
fileprivate struct StandardNavigationTitle: ViewModifier {
    // MARK: Properties
    private let title: String
    
    // MARK: Initializers
    fileprivate init(_ title: String) {
        self.title = title
    }
}

// MARK: - Body
@available(iOS 14, *)
extension StandardNavigationTitle {
    fileprivate func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
    }
}
