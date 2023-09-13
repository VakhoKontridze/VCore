//
//  ProgressViewExtension.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.10.22.
//

import SwiftUI

// MARK: - Progress View Extension
extension View {
    /// Presents `ProgressView` when `ProgressViewParameters` is non-`nil`.
    ///
    ///     @State private var parameters: ProgressViewParameters = .init()
    ///
    ///     var body: some View {
    ///         content
    ///             .progressView(parameters: parameters)
    ///     }
    ///
    public func progressView(
        parameters: ProgressViewParameters?
    ) -> some View {
        self
            .blocksHitTesting(parameters?.isInteractionEnabled == false)
            .overlay(content: {
                if let parameters {
                    ProgressView()
                        .progressViewStyle(progressViewStyle(parameters: parameters))
                        .scaleEffect(parameters.scalingFactor ?? 1)
                }
            })
    }
}

extension View {
    fileprivate func progressViewStyle(parameters: ProgressViewParameters) -> some ProgressViewStyle {
        switch parameters.color {
        case nil: return CircularProgressViewStyle()
        case let color?: return CircularProgressViewStyle(tint: color) // TODO: iOS 16.0 - Refactor with `tint(_:)`
        }
    }
}
