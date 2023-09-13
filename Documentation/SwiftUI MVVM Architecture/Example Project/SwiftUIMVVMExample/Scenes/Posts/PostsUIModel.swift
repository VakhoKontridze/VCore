//  
//  PostsUIModel.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI
import VCore

// MARK: - Posts UI Model
struct PostsUIModel {
    // MARK: Properties
    static var backgroundColor: Color { .init(uiColor: .systemBackground) }

    static var rowPadding: EdgeInsets_HorizontalVertical { .init(horizontal: 20, vertical: 5) }

    // MARK: Initializers
    private init() {}
}
