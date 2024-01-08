//  
//  PostDetailsUIModel.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import UIKit
import VCore

// MARK: - Post Details UI Model
@NonInitializable
struct PostDetailsUIModel {
    static var backgroundColor: UIColor { .systemBackground }

    static var bodyLabelColor: UIColor { .label }
    static var bodyLabelFont: UIFont { .systemFont(ofSize: 14) }
    static var bodyLabelMarginHorizontal: CGFloat { 20 }
    static var bodyLabelMarginTop: CGFloat { 10 }
    static var bodyLabelMarginBottom: CGFloat { 20 }
}
