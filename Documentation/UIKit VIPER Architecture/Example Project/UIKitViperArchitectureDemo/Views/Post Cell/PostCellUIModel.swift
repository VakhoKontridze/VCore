//  
//  PostCellUIModel.swift
//  UIKitViperArchitectureDemo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import UIKit

// MARK: - Post Cell UI Model
struct PostCellUIModel {
    // MARK: Initializers
    private init() {}
    
    // MARK: Layout
    struct Layout {
        // MARK: Properties
        static var titleLabelMarginHor: CGFloat { 20 }
        static var titleLabelMarginTop: CGFloat { 5 }
        
        static var bodyLabelNumberOfLines: Int { 2 }
        static var bodyLabelMarginHor: CGFloat { titleLabelMarginHor }
        static var bodyLabelMarginTop: CGFloat { 2 }
        static var bodyLabelMarginBottom: CGFloat { titleLabelMarginTop }
        
        // MARK: Initializers
        private init() {}
    }
    
    // MARK: Colors
    struct Colors {
        // MARK: Properties
        static var background: UIColor? { .systemBackground }
        
        static var titleLabel: UIColor? { UIColor.label }
        static var bodyLabel: UIColor? { UIColor.secondaryLabel }
        
        // MARK: Initializers
        private init() {}
    }
    
    // MARK: Fonts
    struct Fonts {
        // MARK: Properties
        static var titleLabel: UIFont? { .systemFont(ofSize: 16, weight: .semibold) }
        static var bodyLabel: UIFont? { .systemFont(ofSize: 14) }
        
        // MARK: Initializers
        private init() {}
    }
}
