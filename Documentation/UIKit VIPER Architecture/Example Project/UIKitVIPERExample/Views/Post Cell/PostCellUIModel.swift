//  
//  PostCellUIModel.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import UIKit
import VCore

// MARK: - Post Cell UI Model
@NonInitializable
struct PostCellUIModel {
    static var backgroundColor: UIColor { .systemBackground }

    static var titleLabelColor: UIColor { UIColor.label }
    static var titleLabelFont: UIFont { .systemFont(ofSize: 16, weight: .semibold) }
    static var titleLabelMarginHorizontal: CGFloat { 20 }
    static var titleLabelMarginTop: CGFloat { 5 }

    static var bodyLabelNumberOfLines: Int { 2 }
    static var bodyLabelColor: UIColor { UIColor.secondaryLabel }
    static var bodyLabelFont: UIFont { .systemFont(ofSize: 14) }
    static var bodyLabelMarginHorizontal: CGFloat { titleLabelMarginHorizontal }
    static var bodyLabelMarginTop: CGFloat { 2 }
    static var bodyLabelMarginBottom: CGFloat { titleLabelMarginTop }
}
