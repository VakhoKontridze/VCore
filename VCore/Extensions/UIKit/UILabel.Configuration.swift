//
//  UILabel.Configuration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

import UIKit

// MARK: - Label Configuration
extension UILabel {
    /// Configures `UILabel` with alignment, number of lines, line break mode, color, and font.
    public func configure(
        alignment: NSTextAlignment = .natural,
        numberOfLines: Int = 1,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail,
        color: UIColor?,
        font: UIFont?
    ) {
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
        self.lineBreakMode = lineBreakMode
        self.textColor = color
        self.font = font
    }
    
    /// Initializes `UILabel` with alignment, number of lines, line break mode, color, and font.
    public convenience init(
        alignment: NSTextAlignment = .natural,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail,
        numberOfLines: Int = 1,
        color: UIColor?,
        font: UIFont?
    ) {
        self.init()
        
        configure(
            alignment: alignment,
            numberOfLines: numberOfLines,
            lineBreakMode: lineBreakMode,
            color: color,
            font: font
        )
    }
}
