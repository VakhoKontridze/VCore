//
//  Color+Blend.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.07.22.
//

import SwiftUI

// MARK: - Color + Blend
extension Color { // TODO: iOS 18.0 - Remove
    /// Blends two `Color`s together.
    ///
    ///     let purple: Color = .red.mix(with: .blue, by: 0.5)
    ///
    @available(iOS, deprecated: 18.0, message: "Use native 'mix(with:by:)' instead")
    @available(macOS, deprecated: 15.0, message: "Use native 'mix(with:by:)' instead")
    @available(tvOS, deprecated: 18.0, message: "Use native 'mix(with:by:)' instead")
    @available(watchOS, deprecated: 11.0, message: "Use native 'mix(with:by:)' instead")
    @available(visionOS, deprecated: 2.0, message: "Use native 'mix(with:by:)' instead")
    public static func blend(
        _ color1: Color,
        ratio1: CGFloat = 0.5,
        with color2: Color,
        ratio2: CGFloat = 0.5
    ) -> Color {
#if canImport(UIKit)
        Color(
            uiColor: UIColor(color1).mix(with: UIColor(color2), by: ratio1/(ratio1 + ratio2))
        )
#elseif canImport(AppKit)
        Color(
            nsColor: NSColor(color1).mix(with: NSColor(color2), by: ratio1/(ratio1 + ratio2))
        )
#endif
    }
}

// Previews are covered in respective UIKit/Appkit files
