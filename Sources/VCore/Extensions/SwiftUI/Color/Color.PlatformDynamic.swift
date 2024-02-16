//
//  Color.PlatformDynamic.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16.02.24.
//

import SwiftUI

// MARK: - Color Platform Dynamic
extension Color {
    /// Creates `Color` that generates it's color data dynamically for each platform.
    public static func platformDynamic(
        light: Color,
        dark: Color
    ) -> Self {
#if os(iOS)
        Color.dynamic(light: light, dark: dark)
#elseif os(macOS)
        Color.dynamic(light: light, dark: dark)
#elseif os(tvOS)
        Color.dynamic(light: light, dark: dark)
#elseif os(watchOS)
        dark
#elseif os(visionOS)
        dark
#endif
    }
}

// MARK: - Preview
#if DEBUG

#Preview(body: {
    Text("Lorem ipsum")
        .foregroundStyle(Color.platformDynamic(light: Color.black, dark: Color.white))
        .padding()
})

#endif
