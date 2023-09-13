//
//  PresentationHostGeometryReader.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 09.08.23.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

// MARK: - Presentation Host Geometry Reader
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
struct PresentationHostGeometryReader<Content>: View where Content: View {
    // MARK: Properties
    // `proxy.safeAreaInsets` no longer works, because safe areas are being ignored
    private let window: () -> UIWindow?

    private let content: () -> Content
    
    // MARK: Initializers
    init(
        window: @escaping () -> UIWindow?,
        content: @escaping () -> Content
    ) {
        self.window = window
        self.content = content
    }
    
    // MARK: Body
    var body: some View {
        GeometryReader(content: { proxy in
            content()
                .presentationHostGeometryReaderSize(proxy.size)
                .presentationHostGeometryReaderSafeAreaInsets(window()?.safeAreaInsets.toEdgeInsets ?? EdgeInsets())
        })
        .ignoresSafeArea() // Additional logic is written in `PresentationHostHostingViewControllerContainerViewController`
    }
}

// MARK: - Helpers
extension UIEdgeInsets {
    fileprivate var toEdgeInsets: EdgeInsets {
        .init(
            top: top,
            leading: left,
            bottom: bottom,
            trailing: right
        )
    }
}

#endif
