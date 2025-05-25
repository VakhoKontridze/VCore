//
//  View+SafeAreaPaddings.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.09.23.
//

import SwiftUI

// MARK: - View + Safe Area Paddings
extension View {
    /// Adds padding equal to safe area insets to specific edges of the `View`.
    ///
    /// Can be used to reverse effects of `ignoresSafeArea(_:edges:)` in nested view.
    ///
    ///     var body: some View {
    ///         ZStack(content: {
    ///             Color.gray
    ///
    ///             Color.accentColor
    ///                 .safeAreaPaddings(edges: .all, insets: EdgeInsets(UIDevice.safeAreaInsets))
    ///         })
    ///         .ignoresSafeArea()
    ///     }
    ///
    ///     extension EdgeInsets {
    ///         fileprivate init(_ uiEdgeInsets: UIEdgeInsets) {
    ///             self.init(
    ///                 top: uiEdgeInsets.top,
    ///                 leading: uiEdgeInsets.left,
    ///                 bottom: uiEdgeInsets.bottom,
    ///                 trailing: uiEdgeInsets.right
    ///             )
    ///         }
    ///     }
    ///
    public func safeAreaPaddings(
        edges: Edge.Set,
        insets: EdgeInsets
    ) -> some View {
        self
            .safeAreaPadding(.leading, edges.contains(.leading) ? insets.leading : 0)
            .safeAreaPadding(.trailing, edges.contains(.trailing) ? insets.trailing : 0)
            .safeAreaPadding(.top, edges.contains(.top) ? insets.top : 0)
            .safeAreaPadding(.bottom, edges.contains(.bottom) ? insets.bottom : 0)
    }
}
