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
/// In `MVP`, `VIP`, and `VIPER` architectures, parameters are stored in `Presenter`.
/// in `MVVM` architecture, parameters are stored in`ViewModel.`
///
///     @State private var parameters: ProgressViewParameters? = .init()
///
///     var body: some View {
///         Button("Lorem ipsum", action: {
///             parameters = .init()
///         })
///             .progressView(parameters: parameters)
///     }
///     
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct ProgressViewParameters: Hashable, Identifiable {
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
    
    // MARK: Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(scalingFactor)
        hasher.combine(color)
    }
    
    // MARK: Identifiable
    public var id: Int { hashValue }
}

// MARK: - Factory
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
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

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
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