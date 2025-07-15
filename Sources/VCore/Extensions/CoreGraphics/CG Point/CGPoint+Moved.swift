//
//  CGPoint+Moved.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.09.23.
//

import CoreGraphics

// MARK: - CG Point + Moved Left
extension CGPoint {
    /// Returns `CGPoint` moved left with a given constant.
    ///
    ///     let size: CGPoint = .init(x: 3, y: 4)
    ///         .movedLeft(withValue: 1) // 2x4
    ///
    public func movedLeft(
        withValue value: CGFloat
    ) -> CGPoint {
        .init(
            x: x - value,
            y: y
        )
    }

    /// Moves left `CGPoint` with a given constant.
    ///
    ///     var size: CGPoint = .init(x: 3, y: 4)
    ///     size.moveLeft(withValue: 1) // 2x4
    ///
    mutating public func moveLeft(
        withValue value: CGFloat
    ) {
        x -= value
    }
}

// MARK: - CG Point + Moved Right
extension CGPoint {
    /// Returns `CGPoint` moved right with a given constant.
    ///
    ///     let size: CGPoint = .init(x: 3, y: 4)
    ///         .movedRight(withValue: 1) // 4x4
    ///
    public func movedRight(
        withValue value: CGFloat
    ) -> CGPoint {
        .init(
            x: x + value,
            y: y
        )
    }

    /// Moves left `CGPoint` with a given constant.
    ///
    ///     var size: CGPoint = .init(x: 3, y: 4)
    ///     size.moveRight(withValue: 1) // 4x4
    ///
    mutating public func moveRight(
        withValue value: CGFloat
    ) {
        x += value
    }
}


// MARK: - CG Point + Moved Up
extension CGPoint {
    /// Returns `CGPoint` moved up with a given constant.
    ///
    ///     let size: CGPoint = .init(x: 3, y: 4)
    ///         .movedUp(withValue: 1) // 3x3
    ///
    public func movedUp(
        withValue value: CGFloat
    ) -> CGPoint {
        .init(
            x: x,
            y: y - value
        )
    }

    /// Moves up `CGPoint` with a given constant.
    ///
    ///     var size: CGPoint = .init(x: 3, y: 4)
    ///     size.moveUp(withValue: 1) // 3x3
    ///
    mutating public func moveUp(
        withValue value: CGFloat
    ) {
        y -= value
    }
}

// MARK: - CG Point + Moved Down
extension CGPoint {
    /// Returns `CGPoint` moved down with a given constant.
    ///
    ///     let size: CGPoint = .init(x: 3, y: 4)
    ///         .movedDown(withValue: 1) // 3x5
    ///
    public func movedDown(
        withValue value: CGFloat
    ) -> CGPoint {
        .init(
            x: x,
            y: y + value
        )
    }

    /// Moves up `CGPoint` with a given constant.
    ///
    ///     var size: CGPoint = .init(x: 3, y: 4)
    ///     size.moveDown(withValue: 1) // 3x5
    ///
    mutating public func moveDown(
        withValue value: CGFloat
    ) {
        y += value
    }
}
