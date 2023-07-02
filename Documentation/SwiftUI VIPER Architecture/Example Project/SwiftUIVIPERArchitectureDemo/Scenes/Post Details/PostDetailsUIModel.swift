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
    // MARK: Properties
    static var backgroundColor: Color { .white }

    static var bodyTextColor: Color { .primary }
    static var bodyTextFont: Font { .subheadline }
    static var bodyTextPadding: EdgeInsets_LeadingTrailingTopBottom { .init(leading: 20, trailing: 20, top: 10, bottom: 20) }

    // MARK: Initializers
    private init() {}
}
