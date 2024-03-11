//
//  PostRowViewUIModel.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI
import VCore

// MARK: - Post Row View UI Model
@Uninitializable
struct PostRowViewUIModel {
    static var backgroundColor: Color { .init(uiColor: .systemBackground) }

    static var spacing: CGFloat { 2 }

    static var titleTextColor: Color { .primary }
    static var titleTextFont: Font { .callout.weight(.semibold) }

    static var bodyTextLineLimit: Int { 2 }
    static var bodyTextColor: Color { .secondary }
    static var bodyTextFont: Font { .subheadline }
}
