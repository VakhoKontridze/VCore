//  
//  PostDetailsUIModel.swift
//  UIKitViperArchitectureDemo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import UIKit

// MARK: - Post Details UI Model
struct PostDetailsUIModel {
    // MARK: Initializers
    private init() {}
    
    // MARK: Layout
    struct Layout {
        // MARK: Properties
        static var bodyLabelMarginHor: CGFloat { 20 }
        static var bodyLabelMarginTop: CGFloat { 10 }
        static var bodyLabelMarginBottom: CGFloat { 20 }
        
        // MARK: Initializers
        private init() {}
    }
    
    // MARK: Colors
    struct Colors {
        // MARK: Properties
        static var background: UIColor? { .systemBackground }
        
        static var bodyLabel: UIColor? { .label }
        
        // MARK: Initializers
        private init() {}
    }
    
    // MARK: Fonts
    struct Fonts {
        // MARK: Properties
        static var bodyLabel: UIFont? { .systemFont(ofSize: 14) }
        
        // MARK: Initializers
        private init() {}
    }
}
