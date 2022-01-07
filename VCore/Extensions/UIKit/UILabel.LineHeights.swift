//
//  UILabel.LineHeights.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

import UIKit

// MARK: - Line Heights
extension UILabel {
    /// Calculates and returns single-line natural height constant.
    ///
    /// Used for ensuring that view doesn't flicker when new text is added to empty `UILabel`.
    ///
    /// All properties from `self` are considered when calculating value.
    ///
    /// During calculation of height, text value is passed from `self`. If `nil`, default value of "A" will be used.
    ///
    /// Usage Example:
    ///
    ///     let label: UILabel = .init()
    ///     label.text = "Lorem Ipsum"
    ///
    ///     let height: CGFloat = label.singleLineHeight // 20.33...
    ///
    public var singleLineHeight: CGFloat {
        singleLineHeight(text: {
            guard let text = text, !text.isEmpty else { return "A" }
            return text
        }())
    }
    
    /// Calculates and returns single-line natural height constant.
    ///
    /// Used for ensuring that view doesn't flicker when new text is added to empty `UILabel`.
    ///
    /// All properties from `self` are considered when calculating value.
    ///
    /// Usage Example:
    ///
    ///     let label: UILabel = .init()
    ///
    ///     let height: CGFloat = label.singleLineHeight(text: "Lorem Ipsum") // 20.33...
    ///
    public func singleLineHeight(text: String) -> CGFloat {
        calculateHeight(text: text, numberOfLines: 1)
    }
    
    /// Calculates and returns multi-line natural height constant.
    ///
    /// Used for ensuring that view doesn't flicker when new text is added to empty `UILabel`.
    ///
    /// All properties from `self` are considered when calculating value.
    ///
    /// During calculation of height, text value is passed from `self`. If `nil`, default value of "A" will be used.
    ///
    /// Usage Example:
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
    ///             label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
    ///         label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
    ///     ])
    ///
    ///     // Must be calculated after layout happens
    ///     let height: CGFloat = label.multiLineHeight // 40.66...
    ///
    public var multiLineHeight: CGFloat {
        multiLineHeight(text: {
            guard let text = text, !text.isEmpty else { return "A" }
            return text
        }())
    }

    /// Calculates and returns multi-line natural height constant.
    ///
    /// Used for ensuring that view doesn't flicker when new text is added to empty `UILabel`.
    ///
    /// All properties from `self` are considered when calculating value.
    /// Usage Example:
    ///
    ///     let label: UILabel = .init()
    ///     label.translatesAutoresizingMaskIntoConstraints = false
    ///     label.numberOfLines = 3
    ///
    ///     view.addSubview(label)
    ///
    ///     NSLayoutConstraint.activate([
    ///         label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
    ///             label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
    ///         label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
    ///     ])
    ///
    ///     // Must be calculated after layout happens
    ///     let height: CGFloat = label.multiLineHeight( // 40.66...
    ///         text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    ///     )
    ///
    public func multiLineHeight(text: String) -> CGFloat {
        calculateHeight(text: text, numberOfLines: numberOfLines)
    }

    private func calculateHeight(
        text: String,
        numberOfLines: Int
    ) -> CGFloat {
        let label: UILabel = {
            let label: UILabel = .init()
            
            label.text = text
            
            label.font = font
            label.textAlignment = textAlignment
            label.lineBreakMode = lineBreakMode
            
            label.numberOfLines = numberOfLines
            
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
