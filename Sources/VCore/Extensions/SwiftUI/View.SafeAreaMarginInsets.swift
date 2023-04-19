//
//  View.SafeAreaMarginInsets.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27.06.22.
//

import SwiftUI

// MARK: - Safe Area Margin Insets
@available(iOS 15.0, tvOS 15.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
extension View {
    /// Inserts `Spacer`s with width or height of safe are inset as margins for specified edges.
    ///
    /// Can be used to reverse effects of `ignoresSafeArea(_:edges:)` in nested view.
    ///
    ///     var body: some View {
    ///         ZStack(content: {
    ///             sheetBackground
    ///
    ///             content
    ///                 .padding(padding)
    ///                 .safeAreaMarginInsets(edges: edges)
    ///         })
    ///         .frame(size: size)
    ///         .ignoresSafeArea()
    ///         .offset(isPresented ? offset : initialOffset)
    ///     }
    ///
    @ViewBuilder public func safeAreaMarginInsets(edges: Edge.Set = .all) -> some View {
#if os(iOS) || os(tvOS)
        self
            .safeAreaMarginInset(edge: .leading, width: edges.contains(.leading) ? UIDevice.safeAreaInsetLeft : 0)
            .safeAreaMarginInset(edge: .trailing, width: edges.contains(.trailing) ? UIDevice.safeAreaInsetRight : 0)
            .safeAreaMarginInset(edge: .top, height: edges.contains(.top) ? UIDevice.safeAreaInsetTop : 0)
            .safeAreaMarginInset(edge: .bottom, height: edges.contains(.bottom) ? UIDevice.safeAreaInsetBottom : 0)
#endif
    }
    
    @ViewBuilder private func safeAreaMarginInset(edge: HorizontalEdge, width: CGFloat) -> some View {
#if os(iOS) || os(tvOS)
        self
            .safeAreaInset(edge: edge, content: {
                Spacer()
                    .frame(width: width)
            })
#endif
    }
    
    @ViewBuilder private func safeAreaMarginInset(edge: VerticalEdge, height: CGFloat) -> some View {
#if os(iOS) || os(tvOS)
        self
            .safeAreaInset(edge: edge, content: {
                Spacer()
                    .frame(height: height)
            })
#endif
    }
}
