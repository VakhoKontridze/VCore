//
//  NonInvasiveGeometryReader.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.05.25.
//

import SwiftUI

// MARK: - Non-Invasive Geometry Reader
struct NonInvasiveGeometryReader<Content>: View
    where Content: View
{
    // MARK: Properties
    private let alignment: Alignment
    private let content: (GeometryProxy) -> Content

    // MARK: Initializers
    init(
        alignment: Alignment,
        @ViewBuilder content: @escaping (GeometryProxy) -> Content
    ) {
        self.alignment = alignment
        self.content = content
    }

    // MARK: Body
    var body: some View {
        Color.clear
            .overlay {
                GeometryReader { geometryProxy in
                    ZStack {
                        content(geometryProxy)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
                    .clipped() // Prevents content from going out of bounds
                }
            }
    }
}
