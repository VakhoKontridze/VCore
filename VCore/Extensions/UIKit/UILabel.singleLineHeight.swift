//
//  LabelNaturalHeightConstant.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

import UIKit

// MARK: - Label Single Line Height
extension UILabel {
    /// Calculates and returns natural height constant.
    ///
    /// Used for ensuring that view doesn't flicker when new text is added to empty `UILabel`.
    ///
    /// All properties from `self` are considered when calculating value.
    ///
    /// During calculation of height, text value is passed from `self`. If `nil`, default value of "A" will be used.
    public var singleLineHeight: CGFloat {
        singleLineHeight(text: {
            guard let text = text, !text.isEmpty else { return "A" }
            return text
        }())
    }
    
    /// Calculates and returns natural height constant.
    ///
    /// Used for ensuring that view doesn't flicker when new text is added to empty `UILabel`.
    ///
    /// All properties from `self` are considered when calculating value.
    public func singleLineHeight(text: String) -> CGFloat {
        let label: UILabel = {
            let label: UILabel = .init()
            
            label.text = text
            
            label.font = font
            label.textAlignment = textAlignment
            label.lineBreakMode = lineBreakMode
            
            label.numberOfLines = 1
            
            label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
            label.baselineAdjustment = baselineAdjustment
            label.minimumScaleFactor = minimumScaleFactor
            
            label.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation
            
            label.lineBreakStrategy = lineBreakStrategy
            
            label.preferredMaxLayoutWidth = preferredMaxLayoutWidth
            
            return label
        }()
        
        label.sizeToFit()
        return label.intrinsicContentSize.height
    }
}
