//
//  CGSize.InitWithDimension.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/21/21.
//

import UIKit

// MARK: - Init Size with Dimension
extension CGSize {
    /// Initialzies `CGSize` with dimension.
    public init(dimension: CGFloat) {
        self.init(
            width: dimension,
            height: dimension
        )
    }
}
