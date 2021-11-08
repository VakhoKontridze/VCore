//
//  UIFont.Styling.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/5/21.
//

import UIKit

// MARK: - Font Styling
extension UIFont {
    /// Returns font with bold styling.
    public var withBoldStyling: UIFont? {
        fontDescriptor.withSymbolicTraits(.traitBold).let { .init(descriptor: $0, size: 0) }
    }
    
    /// Returns font with italic styling.
    public var withItalicStyling: UIFont? {
        fontDescriptor.withSymbolicTraits(.traitItalic).let { .init(descriptor: $0, size: 0) }
    }
    
    /// Returns font with monospaced styling.
    public var withMonospacedStyling: UIFont? {
        let settings: [[UIFontDescriptor.FeatureKey: Int]] = [[
            UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
            UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector
        ]]
        
        let attributes: [UIFontDescriptor.AttributeName: [[UIFontDescriptor.FeatureKey: Int]]] = [
            UIFontDescriptor.AttributeName.featureSettings: settings
        ]
        
        return .init(descriptor: fontDescriptor.addingAttributes(attributes), size: 0)
    }
}
