//
//  ProgressViewParameters.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/21/21.
//

import SwiftUI

// MARK: - Progress View Parameters
/// Parameters for presenting an `ProgressView`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, parameters are stored in `Presenter`.
/// in `MVVM` architecture, parameters are stored in`ViewModel.`
///
///     @State private var parameters: ProgressViewParameters = .init(isInteractionDisabled: true)
///
///     var body: some View {
///         content
///             .progressView(parameters: parameters)
///     }
///
@available(iOS 14.0, *)
@available(macOS 11.0, *)
@available(tvOS 14.0, *)
@available(watchOS 7.0, *)
public struct ProgressViewParameters: Hashable, Identifiable {
    // MARK: Properties
    /// Scaling factor.
    public let scalingFactor: CGFloat?
    
    /// Color.
    public let color: Color?
    
    /// Indicates if interaction is disabled.
    public let isInteractionDisabled: Bool
    
    // MARK: Initializers
    /// Initializes `ProgressViewParameters`.
    public init(
        scalingFactor: CGFloat? = nil,
        color: Color? = nil,
        isInteractionDisabled: Bool
    ) {
        self.scalingFactor = scalingFactor
        self.color = color
        self.isInteractionDisabled = isInteractionDisabled
    }
    
    // MARK: Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(scalingFactor)
        hasher.combine(color)
    }
    
    // MARK: Identifiable
    public var id: Int { hashValue }
}
