//
//  Color+LightenAndDarkened.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.07.22.
//

import SwiftUI

nonisolated extension Color {
    /// Returns `Color` lightened by a fraction.
    ///
    ///     let lightBlue: Color = .systemBlue.lightened(by: 0.1)
    ///
    public func lightened(
        by fraction: CGFloat
    ) -> Color {
#if canImport(UIKit)
        Color(uiColor: UIColor(self).lightened(by: fraction))
#elseif canImport(AppKit)
        Color(nsColor: NSColor(self).lightened(by: fraction))
#endif
    }
    
    /// Returns `Color` darkened by a fraction.
    ///
    ///     let darkBlue: Color = .systemBlue.darkened(by: 0.1)
    ///
    public func darkened(
        by fraction: CGFloat
    ) -> Color {
#if canImport(UIKit)
        Color(uiColor: UIColor(self).darkened(by: fraction))
#elseif canImport(AppKit)
        Color(nsColor: NSColor(self).darkened(by: fraction))
#endif
    }
}

// Previews are covered in respective UIKit/Appkit files
