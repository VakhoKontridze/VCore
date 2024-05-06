//
//  CGSize.InitWithDimension.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/21/21.
//

import CoreGraphics

// MARK: - CG Size Init with Dimension
extension CGSize {
    /// Initializes `CGSize` with dimension.
    ///
    ///     let size: CGSize = .init(dimension: 100)
    ///
    public init(dimension: CGFloat) {
        self.init(
            width: dimension,
            height: dimension
        )
    }
}
