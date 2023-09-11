//
//  ProgressViewExtension.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.10.22.
//

import SwiftUI

// MARK: - Progress View Extension
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
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
            .overlay(Group(content: {
                if let parameters {
                    ProgressView()
                        .progressViewStyle(progressViewStyle(parameters: parameters))
                        .scaleEffect(parameters.scalingFactor ?? 1)
                }
            }))
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension View {
    fileprivate func progressViewStyle(parameters: ProgressViewParameters) -> some ProgressViewStyle {
        switch parameters.color {
        case nil: return CircularProgressViewStyle()
        case let color?: return CircularProgressViewStyle(tint: color) // TODO: Refactor when support for `iOS` `16.0` is added
        }
    }
}
