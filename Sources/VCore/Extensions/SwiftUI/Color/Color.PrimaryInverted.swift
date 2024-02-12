//
//  Color.PrimaryInverted.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.01.24.
//

import SwiftUI

// MARK: - Color Primary Inverted
extension Color {
    /// `Color` that can be used for inverted primary content.
    ///
    ///     Text("Lorem ipsum")
    ///         .foregroundStyle(Color.primaryInverted)
    ///         .padding()
    ///         .background(content: { Color.primary })
    ///
    public static let primaryInverted: Color = {
#if os(iOS)
        .dynamic(light: Color.white, dark: Color.black)
#elseif os(macOS)
        .dynamic(light: Color.white, dark: Color.black)
#elseif os(tvOS)
        .dynamic(light: Color.white, dark: Color.black)
#elseif os(watchOS)
        .black
#elseif os(visionOS)
        .black
#endif
    }()
}

// MARK: - Preview
#if DEBUG

#Preview(body: {
    VStack(content: {
        Text("Lorem ipsum")
            .foregroundStyle(.primary)
            .padding()

        Text("Lorem ipsum")
            .foregroundStyle(Color.primaryInverted)
            .padding()
            .background(content: { Color.primary })
    })
})

#endif
