//
//  Color+InitWithRGBA.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 14.07.24.
//

// Internal use only

import SwiftUI

// MARK: - Color + Init with RGBA
extension Color {
    init(
        _ red: CGFloat,
        _ green: CGFloat,
        _ blue: CGFloat,
        _ opacity: CGFloat = 1
    ) {
        self.init(
            red: red/255,
            green: green/255,
            blue: blue/255,
            opacity: opacity
        )
    }
}
