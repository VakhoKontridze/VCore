//  
//  PostDetailsUIModel.swift
//  SwiftUIVIPERArchitectureDemo
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI
import VCore

// MARK: - Post Details UI Model
struct PostDetailsUIModel {
    // MARK: Initializers
    private init() {}
    
    // MARK: Layout
    struct Layout {
        // MARK: Properties
        static var bodyTextPadding: EdgeInsets_LTTB { .init(leading: 20, trailing: 20, top: 10, bottom: 20) }
        
        // MARK: Initializers
        private init() {}
    }

    // MARK: Colors
    struct Colors {
        // MARK: Properties
        static var background: Color { .white }
        
        static var bodyText: Color { .primary }
        
        // MARK: Initializers
        private init() {}
    }

    // MARK: Fonts
    struct Fonts {
        // MARK: Properties
        static var bodyText: Font { .system(size: 14) }
        
        // MARK: Initializers
        private init() {}
    }
}
