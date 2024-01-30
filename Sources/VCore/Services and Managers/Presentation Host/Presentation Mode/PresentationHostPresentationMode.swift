//
//  PresentationHostPresentationMode.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/14/22.
//

import SwiftUI
import Combine

// MARK: - Presentation Host Presentation Mode
/// Object embedded in environment of modals presented via Presentation Host.
///
/// Contains `Publisher`s for detecting modal lifecycle changes.
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
public struct PresentationHostPresentationMode {
    // MARK: Properties - General
    /// Modal identifier.
    public let id: String

    // MARK: Properties - Present
    /// Emits notification when modal should be internally presented.
    public let presentPublisher: AnyPublisher<Void, Never>

    // MARK: Properties - Dismiss
    /// Emits notification when modal should be internally dismissed.
    public let dismissPublisher: AnyPublisher<Void, Never>

    /// Completion block that should be called when internal animations conclude, to remove modal from the view hierarchy.
    public let dismissCompletion: () -> Void

    // MARK: Properties - Interaction
    /// ???.
    public let setInteractiveViewFrame: (CGRect?) -> Void
}
