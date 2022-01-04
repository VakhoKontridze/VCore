//
//  UILabel.Configuration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

import UIKit

// MARK: - Label Configuration
extension UILabel {
    /// Configures `UILabel` with alignment, line break mode, number of lines, color, and font.
    public func configure(
        alignment: NSTextAlignment = .natural,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail,
        numberOfLines: Int = 1,
        color: UIColor?,
        font: UIFont?
    ) {
        self.textAlignment = alignment
        self.lineBreakMode = lineBreakMode
        self.numberOfLines = numberOfLines
        self.textColor = color
        self.font = font
    }
    
    /// Initializes `UILabel` with alignment, line break mode, number of lines, color, and font.
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
            lineBreakMode: lineBreakMode,
            numberOfLines: numberOfLines,
            color: color,
            font: font
        )
    }
}
