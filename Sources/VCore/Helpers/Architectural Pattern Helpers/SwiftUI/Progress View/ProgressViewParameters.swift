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
