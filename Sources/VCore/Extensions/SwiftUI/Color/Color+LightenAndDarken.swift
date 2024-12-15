//
//  Color+LightenAndDarken.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.07.22.
//

import SwiftUI

// MARK: - Color + Lighten and Darken
extension Color {
    /// Lightens `Color` by a fraction.
    ///
    ///     let lightBlue: Color = .systemBlue.lighten(by: 0.1)
    ///
    public func lighten(
        by fraction: CGFloat
    ) -> Color {
#if canImport(UIKit)
        Color(uiColor: UIColor(self).lighten(by: fraction))
#elseif canImport(AppKit)
        Color(nsColor: NSColor(self).lighten(by: fraction))
#endif
    }
    
    /// Darkens `Color` by a fraction.
    ///
    ///     let darkBlue: Color = .systemBlue.darken(by: 0.1)
    ///
    public func darken(
        by fraction: CGFloat
    ) -> Color {
#if canImport(UIKit)
        Color(uiColor: UIColor(self).darken(by: fraction))
#elseif canImport(AppKit)
        Color(nsColor: NSColor(self).darken(by: fraction))
#endif
    }
}

// Previews are covered in respective UIKit/Appkit files
