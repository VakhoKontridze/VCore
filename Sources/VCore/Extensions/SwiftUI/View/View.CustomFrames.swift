//
//  View.CustomFrames.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/6/21.
//

import SwiftUI

// MARK: - View Custom Frames
extension View {
    /// Positions this `View` within an invisible frame with the specified dimension.
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .frame(dimension: 100)
    ///     }
    ///
    public func frame(
        dimension: CGFloat?,
        alignment: Alignment = .center
    ) -> some View {
        self
            .frame(
                width: dimension, 
                height: dimension,
                alignment: alignment
            )
    }
    
    /// Positions this `View` within an invisible frame with the specified size.
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .frame(size: CGSize(dimension: 100))
    ///     }
    ///
    public func frame(
        size: CGSize?,
        alignment: Alignment = .center
    ) -> some View {
        self
            .frame(
                width: size?.width,
                height: size?.height,
                alignment: alignment
            )
    }
}
