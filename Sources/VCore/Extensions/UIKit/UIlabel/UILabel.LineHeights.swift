//
//  UILabel.LineHeights.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Line Heights
extension UILabel {
    /// Calculates and returns single-line natural height constant.
    ///
    /// Used for ensuring that view doesn't flicker when new text is added to empty `UILabel`.
    ///
    /// All properties from `self` are considered when calculating value.
    ///
    /// During calculation of height, `text` value is passed from `self`.
    /// If `nil`, default value of "A" will be used.
    ///
    ///     let label: UILabel = .init()
    ///     label.text = "Lorem Ipsum"
    ///
    ///     let height: CGFloat = label // 20.33...
    ///         .singleLineHeight
    ///
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
    
    /// Calculates and returns multi-line natural height constant.
    ///
    /// Used for ensuring that view doesn't flicker when new text is added to empty `UILabel`.
    ///
    /// All properties from `self` are considered when calculating value.
    ///
    /// During calculation of height, parameter `text` is used.
    /// If nil, `text` value is passed from `self`.
    /// If `nil`, default value of "A" will be used.
    ///
    ///     let label: UILabel = .init()
    ///     label.translatesAutoresizingMaskIntoConstraints = false
    ///     label.numberOfLines = 3
    ///     label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    ///
    ///     view.addSubview(label)
    ///
    ///     NSLayoutConstraint.activate([
    ///         label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
    ///         label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
    ///         label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
    ///     ])
    ///
    /// Multi line height can only be calculated after layout takes place.
    /// Otherwise, `preferredMaxLayoutWidth` parameter will be `0`, and either `0` or a single-line height will be retuned.
    /// To ensure proper calculations, this method must be called after `UILabel` has been laid out.
    /// For instance, this method can be called in `UIView`'s `layoutSubviews`.
    /// In some cases, `async` can also work.
    ///
    ///     DispatchQueue.main.async(execute: {
    ///         let height: CGFloat = label // 40.66...
    ///             .multiLineHeight()
    ///     })
    ///
    /// Alternately, a predefined with value can be passed:
    ///
    ///     let height: CGFloat = label // 40.66...
    ///         .multiLineHeight(
    ///             width: view.frame.size.width - 40
    ///         )
    ///
    public func multiLineHeight(width: CGFloat? = nil, text: String? = nil) -> CGFloat {
        let label: UILabel = {
            let label: UILabel = .init()
            
            label.text = text ?? self.text ?? "A"
            
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
