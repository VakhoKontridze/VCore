//
//  CGSize.Scaled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 05.09.23.
//

import CoreGraphics

// MARK: - Size Scaled with Constant
extension CGSize {
    /// Scales up and returns `CGSize` with a given constant.
    ///
    ///     let size: CGSize = .init(width: 3, height: 4)
    ///     let scaledSize: CGSize = size.scaledUp(withConstant: 1) // 4x5
    ///
    public func scaledUp(
        withConstant value: CGFloat
    ) -> CGSize {
        CGSize(
            width: width + value,
            height: height + value
        )
    }

    /// Scales down and returns `CGSize` with a given constant.
    ///
    ///     let size: CGSize = .init(width: 3, height: 4)
    ///     let scaledSize: CGSize = size.scaledDown(withConstant: 1) // 2x3
    ///
    public func scaledDown(
        withConstant value: CGFloat
    ) -> CGSize {
        CGSize(
            width: width - value,
            height: height - value
        )
    }
}


// MARK: - Size Scaled with Multiplier
extension CGSize {
    /// Scales up and returns `CGSize` with a given multiplier.
    ///
    ///     let size: CGSize = .init(width: 3, height: 4)
    ///     let scaledSize: CGSize = size.scaledUp(withMultiplier: 2) // 6x8
    ///
    public func scaledUp(
        withMultiplier value: CGFloat
    ) -> CGSize {
        CGSize(
            width: width * value,
            height: height * value
        )
    }

    /// Scales down and returns `CGSize` with a given multiplier.
    ///
    ///     let size: CGSize = .init(width: 3, height: 4)
    ///     let scaledSize: CGSize = size.scaledDown(withMultiplier: 2) // 1.5x2
    ///
    public func scaledDown(
        withMultiplier value: CGFloat
    ) -> CGSize {
        CGSize(
            width: width / value,
            height: height / value
        )
    }
}
