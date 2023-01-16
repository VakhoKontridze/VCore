//
//  PostRowViewUIModel.swift
//  SwiftUIVIPERArchitectureDemo
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI
import VCore

// MARK: - Post Row View UI Model
struct PostRowViewUIModel {
    // MARK: Initializers
    private init() {}
    
    // MARK: Layout
    struct Layout {
        // MARK: Properties
        static var padding: EdgeInsets_HorizontalVertical { .init(horizontal: 20, vertical: 5) }
        static var spacing: CGFloat { 2 }
        
        static var bodyTextLineLimit: Int { 2 }
        
        // MARK: Initializers
        private init() {}
    }

    // MARK: Colors
    struct Colors {
        // MARK: Properties
        static var background: Color { .init(.systemBackground) }
        
        static var titleText: Color { .primary }
        static var bodyText: Color? { .secondary }
        
        // MARK: Initializers
        private init() {}
    }

    // MARK: Fonts
    struct Fonts {
        // MARK: Properties
        static var titleText: Font { .system(size: 16, weight: .semibold) }
        static var bodyText: Font { .system(size: 14) }
        
        // MARK: Initializers
        private init() {}
    }
}
