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
///     @State private var parameters: ProgressViewParameters = .init()
///
///     var body: some View {
///         content
///             .progressView(parameters: parameters)
///     }
///
public struct ProgressViewParameters {
    // MARK: Properties
    /// Scaling factor.
    public var scalingFactor: CGFloat?
    
    /// Color.
    public var color: Color?
    
    /// Indicates if interaction is enabled.
    public var isInteractionEnabled: Bool

    /// Attributes.
    public var attributes: [String: Any?]

    // MARK: Initializers
    /// Initializes `ProgressViewParameters`.
    public init(
        scalingFactor: CGFloat? = nil,
        color: Color? = nil,
        isInteractionEnabled: Bool = true,
        attributes: [String: Any?] = [:]
    ) {
        self.scalingFactor = scalingFactor
        self.color = color
        self.isInteractionEnabled = isInteractionEnabled
        self.attributes = attributes
    }
}
