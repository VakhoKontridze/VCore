//
//  Color+PlatformDynamic.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16.02.24.
//

import SwiftUI

// MARK: - Color + Platform Dynamic
extension Color {
    /// Creates `Color` that generates it's color data dynamically for each platform.
    ///
    ///     let color: Color = .dynamic(Color.black, Color.white)
    ///
    public static func platformDynamic(
        _ light: Color,
        _ dark: Color
    ) -> Self {
#if os(iOS)
        Color.dynamic(light, dark)
#elseif os(macOS)
        Color.dynamic(light, dark)
#elseif os(tvOS)
        Color.dynamic(light, dark)
#elseif os(watchOS)
        dark
#elseif os(visionOS)
        dark
#endif
    }
}

// MARK: - Preview
#if DEBUG

#Preview {
    Text("Lorem ipsum")
        .foregroundStyle(Color.platformDynamic(Color.black, Color.white))
        .padding()
}

#endif
