//
//  LabelConfiguration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

import UIKit

// MARK:- Label Configuration
extension UILabel {
    /// Configures `UILabel` with font, color, alignment, number of lines, and line break mode
    public func configure(
        font: UIFont?,
        color: UIColor?,
        alignment: NSTextAlignment = .natural,
        numberOfLines: Int = 1,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail
    ) {
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
        self.lineBreakMode = lineBreakMode
    }
    
    /// Initializes `UILabel` with font, color, alignment, number of lines, and line break mode
    public convenience init(
        font: UIFont?,
        color: UIColor?,
        alignment: NSTextAlignment = .natural,
        numberOfLines: Int = 1,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail
    ) {
        self.init()
        
        configure(
            font: font,
            color: color,
            alignment: alignment,
            numberOfLines: numberOfLines,
            lineBreakMode: lineBreakMode
        )
    }
}
