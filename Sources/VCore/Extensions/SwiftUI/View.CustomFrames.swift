//
//  View.CustomFrames.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/6/21.
//

import SwiftUI

// MARK: - Custom View Frames
extension View {
    /// Positions this `View` within an invisible frame with the specified dimension.
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .frame(dimension: 100)
    ///     }
    ///
    public func frame(
        dimension: CGFloat,
        alignment: Alignment = .center
    ) -> some View {
        frame(
            width: dimension, height: dimension,
            alignment: alignment
        )
    }
    
    /// Positions this `View` within an invisible frame with the specified size.
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .frame(size: .init(dimension: 100))
    ///     }
    ///
    public func frame(
        size: CGSize,
        alignment: Alignment = .center
    ) -> some View {
        frame(
            width: size.width,
            height: size.height,
            alignment: alignment
        )
    }
    
    /// Positions this `View` within an invisible frame with the specified size configuration.
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .frame(size: .init(
    ///                 min: .zero,
    ///                 ideal: .init(dimension: 100),
    ///                 max: .init(dimension: .infinity)
    ///             ))
    ///     }
    ///
    public func frame(
        size: MinIdealMaxSizes,
        alignment: Alignment = .center
    ) -> some View {
        frame(
            minWidth: size.min.width,
            idealWidth: size.ideal.width,
            maxWidth: size.max.width,
            
            minHeight: size.min.height,
            idealHeight: size.ideal.height,
            maxHeight: size.max.height,
            
            alignment: alignment
        )
    }
}

// MARK: - Min Ideal Max Sizes
/// Object containing minimum, ideal, and maximum size configurations.
public struct MinIdealMaxSizes {
    // MARK: Properties
    /// Minimum size.
    public var min: CGSize
    
    /// Ideal size.
    public var ideal: CGSize
    
    /// Maximum size.
    public var max: CGSize
    
    // MARK: Initializers
    /// Initializes `MinIdealMaxSizes`.
    public init(min: CGSize, ideal: CGSize, max: CGSize) {
        self.min = min
        self.ideal = ideal
        self.max = max
    }
}
