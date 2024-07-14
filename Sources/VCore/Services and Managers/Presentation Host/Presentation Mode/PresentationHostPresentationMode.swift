//
//  PresentationHostPresentationMode.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/14/22.
//

import Foundation
import Combine

// MARK: - Presentation Host Presentation Mode
/// Presentation mode object embedded in environment of modals presented via Presentation Host.
public struct PresentationHostPresentationMode {
    // MARK: Properties - General
    /// Modal identifier.
    public let id: String

    // MARK: Properties - Present
    let presentSubject: PassthroughSubject<Void, Never> = .init()

    /// Emits notification when modal should be internally presented.
    public var presentPublisher: AnyPublisher<Void, Never> { presentSubject.eraseToAnyPublisher() }

    // MARK: Properties - Dismiss
    let dismissSubject: PassthroughSubject</*completion:*/() -> Void, Never> = .init()

    /// Emits notification when modal should be internally dismissed.
    ///
    /// `Publisher` passes a completion block that must be called when animation finishes.
    public var dismissPublisher: AnyPublisher</*completion:*/() -> Void, Never> { dismissSubject.eraseToAnyPublisher() }

    // MARK: Properties - Misc
    let dimmingViewTapActionSubject: PassthroughSubject<Void, Never> = .init()

    /// Emits notification when dimming view is tapped.
    ///
    /// Will only be called if `PresentationHostLayerUIModel.dimmingViewTapAction` is set to `sendActionToTopmostModal`.
    public var dimmingViewTapActionPublisher: AnyPublisher<Void, Never> { dimmingViewTapActionSubject.eraseToAnyPublisher() }

    // MARK: Initializers
    init(
        id: String
    ) {
        self.id = id
    }
}
