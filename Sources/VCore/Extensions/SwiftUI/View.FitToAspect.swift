//
//  File.swift
//  
//
//  Created by Vakhtang Kontridze on 09.09.22.
//

import SwiftUI

// MARK: - View Fit to Aspect
extension View {
    /// Constrains this `View`'s dimensions to the specified aspect ratio without stretching it.
    ///
    ///     Image(named: "SomeImage")
    ///         .resizable()
    ///         .fitToAspect(1, contentMode: .fit)
    ///         .background(Color.black)
    ///         .frame(dimension: 100)
    ///
    public func fitToAspect(
        _ aspectRatio: Double,
        contentMode: ContentMode
    ) -> some View {
        Color.clear
            .scaledToFill()
            .aspectRatio(aspectRatio, contentMode: .fit)
            .overlay(self.aspectRatio(nil, contentMode: contentMode))
            .clipShape(Rectangle())
    }
}
