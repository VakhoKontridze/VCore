//
//  View+FitToAspect.swift
//  
//  VCore
//  Created by Vakhtang Kontridze on 09.09.22.
//

import SwiftUI

// MARK: - View + Fit to Aspect
extension View {
    /// Constrains `View`'s dimensions to the specified aspect ratio without stretching it.
    ///
    ///     Image("Image")
    ///         .resizable()
    ///         .fitToAspect(1, contentMode: .fit)
    ///         .background(Color.primary)
    ///         .frame(dimension: 200)
    ///
    public func fitToAspect(
        _ aspectRatio: Double,
        contentMode: ContentMode
    ) -> some View {
        Color.clear
            .scaledToFill()
            .aspectRatio(aspectRatio, contentMode: .fit)
            .overlay { self.aspectRatio(nil, contentMode: contentMode) }
            .clipShape(.rect)
    }
}

// MARK: - Preview
#if DEBUG

#Preview {
    let size: CGSize = .init(width: 150, height: 200)

#if canImport(UIKit)

    guard
        let uiImage: UIImage = .init(
            size: size,
            color: {
#if os(watchOS)
                UIColor.blue
#else
                UIColor.systemBlue
#endif
            }()
        )
    else {
        return EmptyView()
    }
    let image: Image = .init(uiImage: uiImage)

#elseif canImport(AppKit)

    guard
        let nsImage: NSImage = .init(
            size: size,
            color: NSColor.systemBlue
        )
    else {
        return EmptyView()
    }
    let image: Image = .init(nsImage: nsImage)

#endif

    return image
        .resizable()
        .fitToAspect(1, contentMode: .fit)
        .background(Color.primary)
        .frame(dimension: 200)
}

#endif
