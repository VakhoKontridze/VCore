//
//  RectCorner.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.03.23.
//

import Foundation

// MARK: - Rect Corner
/// Corners of a rectangle.
///
/// Unlike `UIRectCorner`, `RectCorner` is multi-platform.
public struct RectCorner: OptionSet {
    // MARK: Options
    /// Top-left corner of the rectangle.
    public static let topLeft: Self = .init(rawValue: 1 << 0)
    
    /// Top-right corner of the rectangle.
    public static let topRight: Self = .init(rawValue: 1 << 1)
    
    /// Bottom-right corner of the rectangle.
    public static let bottomRight: Self = .init(rawValue: 1 << 2)
    
    /// Bottom-left corner of the rectangle.
    public static let bottomLeft: Self = .init(rawValue: 1 << 3)
    
    // MARK: Options Initializers
    /// All corners of the rectangle.
    public static var allCorners: Self = [.topLeft, topRight, .bottomLeft, .bottomRight]
    
    /// Top corners of the rectangle.
    ///
    /// Includes `topLeft` and  `topRight`.
    public static var topCorners: Self { [.topLeft, .topRight] }
    
    /// Right corners of the rectangle.
    ///
    /// Includes `topRight` and  `bottomRight`.
    public static var rightCorners: Self { [.topRight, .bottomRight] }
    
    /// Bottom corners of the rectangle.
    ///
    /// Includes `bottomLeft` and  `bottomRight`.
    public static var bottomCorners: Self { [.bottomLeft, .bottomRight] }
    
    /// Left corners of the rectangle.
    ///
    /// Includes `topLeft` and  `bottomLeft`.
    public static var leftCorners: Self { [.topLeft, .bottomLeft] }
    
    // MARK: Properties
    public let rawValue: Int
    
    // MARK: Initializers
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    // MARK: Reversing Left and Right Corners
    /// Returns `RectCorner` with reversed left and right corners if condition is met.
    ///
    /// Cane be used when supporting RTL languages.
    public func withReversedLeftAndRightCorners(
        _ condition: Bool = true
    ) -> Self {
        guard condition else { return self }
        
        var result: Self = .init()
        
        switch (contains(.topLeft), contains(.topRight)) {
        case (false, false): break
        case (false, true): result.insert(.topLeft)
        case (true, false): result.insert(.topRight)
        case (true, true): result.insert(.topCorners)
        }
        
        switch (contains(.bottomRight), contains(.bottomLeft)) {
        case (false, false): break
        case (false, true): result.insert(.bottomRight)
        case (true, false): result.insert(.bottomLeft)
        case (true, true): result.insert(.bottomCorners)
        }
        
        return result
    }
}
