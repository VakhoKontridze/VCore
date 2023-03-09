//
//  View.SafeAreaMarginInsets.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27.06.22.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

// MARK: - Safe Area Margin Insets
@available(iOS 15.0, tvOS 15.0, *)
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
    ///             .frame(size: size)
    ///             .ignoresSafeArea()
    ///             .offset(isPresented ? offset : initialOffset)
    ///     }
    ///
    public func safeAreaMarginInsets(edges: Edge.Set = .all) -> some View {
        self
            .if(edges.contains(.leading), transform: {
                $0.safeAreaMarginInset(edge: .leading, width: UIDevice.safeAreaInsetLeft)
            })
            
            .if(edges.contains(.trailing), transform: {
                $0.safeAreaMarginInset(edge: .trailing, width: UIDevice.safeAreaInsetRight)
            })
            
            .if(edges.contains(.top), transform: {
                $0.safeAreaMarginInset(edge: .top, height: UIDevice.safeAreaInsetTop)
            })
            
            .if(edges.contains(.bottom), transform: {
                $0.safeAreaMarginInset(edge: .bottom, height: UIDevice.safeAreaInsetBottom)
            })
    }
    
    @ViewBuilder private func safeAreaMarginInset(edge: HorizontalEdge, width: CGFloat) -> some View {
        if width == 0 {
            self
        } else {
            self
                .safeAreaInset(edge: edge, content: {
                    Spacer()
                        .frame(width: width)
                })
        }
    }
    
    @ViewBuilder private func safeAreaMarginInset(edge: VerticalEdge, height: CGFloat) -> some View {
        if height == 0 {
            self
        } else {
            self
                .safeAreaInset(edge: edge, content: {
                    Spacer()
                        .frame(height: height)
                })
        }
    }
}

#endif
