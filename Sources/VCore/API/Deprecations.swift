//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import SwiftUI

#if canImport(UIKit) && !os(watchOS)

import UIKit

extension UILabel {
    @available(*, deprecated, message: "Will be removed in '9.0.0'")
    public var singleLineHeight: CGFloat {
        let label: UILabel = { // `preferredMaxLayoutWidth` is not set
            let label: UILabel = .init()
            
            label.text = text?.nonEmpty ?? "A"
            
            label.font = font
            label.textAlignment = textAlignment
            label.lineBreakMode = lineBreakMode
            
            label.numberOfLines = 1
            
            label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
            label.baselineAdjustment = baselineAdjustment
            label.minimumScaleFactor = minimumScaleFactor
            
            label.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation
            
            label.lineBreakStrategy = lineBreakStrategy

            label.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory
            label.minimumContentSizeCategory = minimumContentSizeCategory
            label.maximumContentSizeCategory = maximumContentSizeCategory
            
            return label
        }()
        
        label.sizeToFit()
        return label.intrinsicContentSize.height
    }
    
    @available(*, deprecated, message: "Will be removed in '9.0.0'")
    public func multiLineHeight(width: CGFloat? = nil, text: String? = nil) -> CGFloat {
        let label: UILabel = {
            let label: UILabel = .init()
            
            label.text = text?.nonEmpty ?? self.text?.nonEmpty ?? "A"
            
            label.font = font
            label.textAlignment = textAlignment
            label.lineBreakMode = lineBreakMode
            
            label.numberOfLines = numberOfLines
            
            label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
            label.baselineAdjustment = baselineAdjustment
            label.minimumScaleFactor = minimumScaleFactor
            
            label.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation
            
            label.lineBreakStrategy = lineBreakStrategy

            label.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory
            label.minimumContentSizeCategory = minimumContentSizeCategory
            label.maximumContentSizeCategory = maximumContentSizeCategory
            
            label.preferredMaxLayoutWidth = width ?? preferredMaxLayoutWidth
            
            return label
        }()
        
        label.sizeToFit()
        return label.intrinsicContentSize.height
    }
}

#endif
