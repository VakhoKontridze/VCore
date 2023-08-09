//
//  PresentationHostGeometryReader.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 09.08.23.
//

import SwiftUI

// MARK: - Presentation Host Geometry Reader
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
struct PresentationHostGeometryReader<Content>: View where Content: View {
    // MARK: Properties
    private let content: () -> Content
    
    // MARK: Initializers
    init(
        content: @escaping () -> Content
    ) {
        self.content = content
    }
    
    // MARK: Body
    var body: some View {
        GeometryReader(content: { proxy in
            content()
                .presentationHostGeometryReaderSize(proxy.size)
                .presentationHostGeometryReaderSafeAreaInsets(proxy.safeAreaInsets)
        })
    }
}
