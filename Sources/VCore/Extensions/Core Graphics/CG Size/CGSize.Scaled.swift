//
//  CGSize.Scaled.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 05.09.23.
//

import CoreGraphics

// MARK: - CG Size Scaled Up with Constant
extension CGSize {
    /// Returns `CGSize` scaled up with a given constant.
    ///
    ///     let size: CGSize = .init(width: 3, height: 4)
    ///         .scaledUp(withConstant: 1) // 4x5
    ///
    public func scaledUp(
        withConstant value: CGFloat
    ) -> CGSize {
        .init(
            width: width + value,
            height: height + value
        )
    }

    /// Scales up `CGSize` with a given constant.
    ///
    ///     var size: CGSize = .init(width: 3, height: 4)
    ///     size.scaleUp(withConstant: 1) // 4x5
    ///
    mutating public func scaleUp(
        withConstant value: CGFloat
    ) {
        width += value
        height += value
    }
}

// MARK: - CG Size Scaled Down with Constant
extension CGSize {
    /// Returns `CGSize` scaled down with a given constant.
    ///
    ///     let size: CGSize = .init(width: 3, height: 4)
    ///         .scaledDown(withConstant: 1) // 2x3
    ///
    public func scaledDown(
        withConstant value: CGFloat
    ) -> CGSize {
        .init(
            width: width - value,
            height: height - value
        )
    }

    /// Scales up `CGSize` with a given constant.
    ///
    ///     var size: CGSize = .init(width: 3, height: 4)
    ///     size.scaleDown(withConstant: 1) // 2x3
    ///
    mutating public func scaleDown(
        withConstant value: CGFloat
    ) {
        width -= value
        height -= value
    }
}

// MARK: - CG Size Scaled Up with Multiplier
extension CGSize {
    /// Returns `CGSize` scaled up with a given multiplier.
    ///
    ///     let size: CGSize = .init(width: 3, height: 4)
    ///         .scaledUp(withMultiplier: 2) // 6x8
    ///
    public func scaledUp(
        withMultiplier value: CGFloat
    ) -> CGSize {
        .init(
            width: width * value,
            height: height * value
        )
    }

    /// Scales up `CGSize` with a given multiplier.
    ///
    ///     var size: CGSize = .init(width: 3, height: 4)
    ///     size.scaleUp(withMultiplier: 2) // 6x8
    ///
    mutating public func scaleUp(
        withMultiplier value: CGFloat
    ) {
        width *= value
        height *= value
    }
}

// MARK: - CG Size Scaled Down with Multiplier
extension CGSize {
    /// Returns `CGSize` scaled down with a given multiplier.
    ///
    ///     let size: CGSize = .init(width: 3, height: 4)
    ///         .scaledDown(withMultiplier: 2) // 1.5x2
    ///
    public func scaledDown(
        withMultiplier value: CGFloat
    ) -> CGSize {
        .init(
            width: width / value,
            height: height / value
        )
    }

    /// Scales down `CGSize` with a given multiplier.
    ///
    ///     var size: CGSize = .init(width: 3, height: 4)
    ///     size.scaleDown(withMultiplier: 2) // 1.5x2
    ///
    mutating public func scaleDown(
        withMultiplier value: CGFloat
    ) {
        width /= value
        height /= value
    }
}
