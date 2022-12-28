//
//  ProgressViewExtension.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.10.22.
//

import SwiftUI

// MARK: - Progress View Extension
@available(iOS 14.0, *)
@available(macOS 11.0, *)
@available(tvOS 14.0, *)
@available(watchOS 7.0, *)
extension View {
    /// Presents `ProgressView` when `ProgressViewParameters` is non-`nil`.
    ///
    ///     @State private var parameters: ProgressViewParameters = .init(isInteractionDisabled: true)
    ///
    ///     var body: some View {
    ///         content
    ///             .progressView(parameters: parameters)
    ///     }
    ///
    @ViewBuilder public func progressView(
        parameters: ProgressViewParameters?
    ) -> some View {
        switch parameters {
        case nil:
            self
            
        case let parameters?:
            self
                .if(parameters.isInteractionDisabled, transform: {
                    $0
                        .overlay(Color.clear.contentShape(Rectangle()))
                })
                .overlay(
                    ProgressView()
                        .scaleEffect(parameters: parameters)
                        .progressViewStyle(parameters: parameters)
                )
        }
    }
}

@available(iOS 14.0, *)
@available(macOS 11.0, *)
@available(tvOS 14.0, *)
@available(watchOS 7.0, *)
extension View {
    @ViewBuilder fileprivate func progressViewStyle(parameters: ProgressViewParameters) -> some View {
        switch parameters.color {
        case nil: self.progressViewStyle(CircularProgressViewStyle())
        case let color?: self.progressViewStyle(CircularProgressViewStyle(tint: color))
        }
    }
    
    @ViewBuilder fileprivate func scaleEffect(parameters: ProgressViewParameters) -> some View {
        switch parameters.scalingFactor {
        case nil: self
        case let scalingFactor?: self.scaleEffect(x: scalingFactor, y: scalingFactor, anchor: .center)
        }
    }
}
