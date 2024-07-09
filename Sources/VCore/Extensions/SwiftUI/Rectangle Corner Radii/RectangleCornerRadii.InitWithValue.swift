//
//  RectangleCornerRadii.InitWithValue.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 09.07.24.
//

import SwiftUI

// MARK: - Rectangle Corner Radii Init with Value
extension RectangleCornerRadii {
    /// Initializes `RectangleCornerRadii` with `value.
    public init(_ value: CGFloat) {
        self.init(
            topLeading: value,
            bottomLeading: value,
            bottomTrailing: value,
            topTrailing: value
        )
    }
}
