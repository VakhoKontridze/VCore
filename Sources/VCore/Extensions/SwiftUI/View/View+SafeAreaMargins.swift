//
//  View+SafeAreaMargins.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27.06.22.
//

import SwiftUI

// MARK: - View + Safe Area Margins
extension View { // TODO: iOS 17.0 - Remove, as it's obsoleted by `safeAreaPadding(...)`
    /// Adds padding equal to safe area insets to specific edges of the `View`.
    ///
    /// Can be used to reverse effects of `ignoresSafeArea(_:edges:)` in nested view.
    ///
    ///     var body: some View {
    ///         ZStack(content: {
    ///             Color.gray
    ///
    ///             Color.accentColor
    ///                 .safeAreaMargins(edges: .all, insets: EdgeInsets(UIDevice.safeAreaInsets))
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
    @ViewBuilder
    public func safeAreaMargins(
        edges: Edge.Set,
        insets: EdgeInsets
    ) -> some View {
#if canImport(UIKit) && !os(watchOS)
        self
            .padding(.leading, edges.contains(.leading) ? insets.leading : 0)
            .padding(.trailing, edges.contains(.trailing) ? insets.trailing : 0)
            .padding(.top, edges.contains(.top) ? insets.top : 0)
            .padding(.bottom, edges.contains(.bottom) ? insets.bottom : 0)
#endif
    }
}
