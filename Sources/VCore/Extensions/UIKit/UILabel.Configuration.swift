//
//  UILabel.Configuration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Label Configuration
extension UILabel {
    /// Configures `UILabel` with alignment, line break mode, number of lines, color, and font.
    ///
    /// Usage Example:
    ///
    ///     let label: UILabel = .init()
    ///
    ///     label.configure(
    ///         alignment: .natural,
    ///         lineBreakMode: .byTruncatingTail,
    ///         numberOfLines: 3,
    ///         minimumScaleFactor: 0.5,
    ///         color: .label,
    ///         font: .systemFont(ofSize: 13)
    ///     )
    ///
    public func configure(
        alignment: NSTextAlignment = .natural,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail,
        numberOfLines: Int = 1,
        minimumScaleFactor: CGFloat = 0,
        color: UIColor?,
        font: UIFont?
    ) {
        self.textAlignment = alignment
        self.lineBreakMode = lineBreakMode
        self.numberOfLines = numberOfLines
        self.minimumScaleFactor = minimumScaleFactor
        self.textColor = color
        self.font = font
    }
    
    /// Initializes `UILabel` with alignment, line break mode, number of lines, color, and font.
    ///
    /// Usage Example:
    ///
    ///     let label: UILabel = .init(
    ///         alignment: .natural,
    ///         lineBreakMode: .byTruncatingTail,
    ///         numberOfLines: 3,
    ///         minimumScaleFactor: 0.5,
    ///         color: .label,
    ///         font: .systemFont(ofSize: 13)
    ///     )
    ///
    public convenience init(
        alignment: NSTextAlignment = .natural,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail,
        numberOfLines: Int = 1,
        minimumScaleFactor: CGFloat = 0,
        color: UIColor?,
        font: UIFont?
    ) {
        self.init()
        
        configure(
            alignment: alignment,
            lineBreakMode: lineBreakMode,
            numberOfLines: numberOfLines,
            minimumScaleFactor: minimumScaleFactor,
            color: color,
            font: font
        )
    }
}

#endif
