//
//  ProgressViewViewModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/21/21.
//

import SwiftUI

// MARK: - Progress View ViewModel
/// Progress View ViewModel.
///
/// Viewmodel for presenting an `ProgressView`.
///
/// In `VIP` and `VIPER` arhcitecutes, viewmodel is stored in `Presenter`.
@available(iOS 14, *)
public struct ProgressViewViewModel {
    // MARK: Properties
    public let isInteractionDisabled: Bool
    public let scalingFactor: CGFloat?
    public let color: Color?
    
    // MARK: Initializers
    public init(
        isInteractionDisabled: Bool,
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
    /// Presents `ProgressView` when `viewModel` parameter is non-nil
    @ViewBuilder public func progressView(
        viewModel: ProgressViewViewModel?
    ) -> some View {
        switch viewModel {
        case nil:
            self
            
        case let viewModel?:
            self
                .disabled(viewModel.isInteractionDisabled)
                .overlay(
                    ProgressView()
                        .scaleEffect(viewModel: viewModel)
                        .progressViewStyle(viewModel: viewModel)
                )
        }
    }
}

@available(iOS 14, *)
extension View {
    @ViewBuilder fileprivate func progressViewStyle(viewModel: ProgressViewViewModel) -> some View {
        switch viewModel.color {
        case nil: self.progressViewStyle(CircularProgressViewStyle())
        case let color?: self.progressViewStyle(CircularProgressViewStyle(tint: color))
        }
    }
    
    @ViewBuilder fileprivate func scaleEffect(viewModel: ProgressViewViewModel) -> some View {
        switch viewModel.scalingFactor {
        case nil: self
        case let scalingFactor?: self.scaleEffect(x: scalingFactor, y: scalingFactor, anchor: .center)
        }
    }
}
