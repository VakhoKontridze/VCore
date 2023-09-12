//  
//  PostCellUIModel.swift
//  UIKitViperArchitectureDemo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import UIKit

// MARK: - Post Cell UI Model
struct PostCellUIModel {
    // MARK: Properties
    static var backgroundColor: UIColor { .systemBackground }

    static var titleLabelColor: UIColor { UIColor.label }
    static var titleLabelFont: UIFont { .systemFont(ofSize: 16, weight: .semibold) }
    static var titleLabelMarginHor: CGFloat { 20 }
    static var titleLabelMarginTop: CGFloat { 5 }

    static var bodyLabelNumberOfLines: Int { 2 }
    static var bodyLabelColor: UIColor { UIColor.secondaryLabel }
    static var bodyLabelFont: UIFont { .systemFont(ofSize: 14) }
    static var bodyLabelMarginHor: CGFloat { titleLabelMarginHor }
    static var bodyLabelMarginTop: CGFloat { 2 }
    static var bodyLabelMarginBottom: CGFloat { titleLabelMarginTop }

    // MARK: Initializers
    private init() {}
}
