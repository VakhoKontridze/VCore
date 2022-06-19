//
//  ProgressViewParameters.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/21/21.
//

import SwiftUI

// MARK: - Progress View Parameters
/// Progress View Parameters.
///
/// Parameters for presenting an `ProgressView`.
///
/// In `MVP`, `VIP`, and `VIPER` arhcitecutes, parameters are stored in `Presenter`.
/// in `MVVM`, parameters are stored in`ViewModel.`
@available(iOS 14, *)
public struct ProgressViewParameters {
    // MARK: Properties
    public let isInteractionDisabled: Bool
    public let scalingFactor: CGFloat?
    public let color: Color?
    
    // MARK: Initializers
    public init(
        isInteractionDisabled: Bool = false,
        scalingFactor: CGFloat? = nil,
        color: Color? = nil
    ) {
        self.isInteractionDisabled = isInteractionDisabled
        self.scalingFactor = scalingFactor
        self.color = color
    }
}

// MARK: - Factory
@available(iOS 14, *)
extension View {
    /// Presents `ProgressView` when `ProgressViewParameters` is non-`nil`.
    @ViewBuilder public func progressView(
        parameters: ProgressViewParameters?
    ) -> some View {
        switch parameters {
        case nil:
            self
            
        case let parameters?:
            self
                .disabled(parameters.isInteractionDisabled)
                .overlay(
                    ProgressView()
                        .scaleEffect(parameters: parameters)
                        .progressViewStyle(parameters: parameters)
                )
        }
    }
}

@available(iOS 14, *)
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
