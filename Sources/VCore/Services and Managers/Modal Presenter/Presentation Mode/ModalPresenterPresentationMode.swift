//
//  ModalPresenterPresentationMode.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/14/22.
//

import Foundation
import Combine

// MARK: - Modal Presenter Presentation Mode
/// Presentation mode object embedded in environment of modals presented via Modal Presenter.
public struct ModalPresenterPresentationMode {
    // MARK: Properties - General
    /// Identifier.
    public let linkID: String

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
    /// Will only be called if `ModalPresenterRootUIModel.dimmingViewTapAction` is set to `sendActionToTopmostModal`.
    public var dimmingViewTapActionPublisher: AnyPublisher<Void, Never> { dimmingViewTapActionSubject.eraseToAnyPublisher() }

    // MARK: Initializers
    init(
        linkID: String
    ) {
        self.linkID = linkID
    }
}
