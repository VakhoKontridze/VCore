//
//  CGSize+MinAndMaxDimensions.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.09.23.
//

import CoreGraphics

// MARK: - CG Size + Min and Max Dimensions
extension CGSize {
    /// Returns minimum of `width` and `height`.
    ///
    ///     var body: some View {
    ///         someView
    ///             .frame(dimension: screenSize.minDimension() * 0.5)
    ///     }
    ///
    public func minDimension() -> CGFloat {
        min(width, height)
    }

    /// Returns maximum of `width` and `height`.
    ///
    ///     var body: some View {
    ///         someView
    ///             .frame(dimension: screenSize.maxDimension() * 0.5)
    ///     }
    ///
    public func maxDimension() -> CGFloat {
        max(width, height)
    }
}
