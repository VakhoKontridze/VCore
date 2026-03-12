//
//  ModalPresenterContext.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/14/22.
//

import SwiftUI
import Observation
import Combine

/// Presentation mode object embedded in environment of modals presented via Modal Presenter.
@MainActor
@Observable
public final class ModalPresenterContext {
    // MARK: Properties - Identification
    /// Link.
    @ObservationIgnored public let link: ModalPresenterLink
    
    // MARK: Properties - Appearance
    /// Interface orientation.
    internal(set) public var interfaceOrientation: PlatformInterfaceOrientation = .portrait
    
    /// Container size.
    internal(set) public var containerSize: CGSize = .zero
    
    /// Safe area insets.
    internal(set) public var safeAreaInsets: EdgeInsets = .init()

    // MARK: Properties - Present
    @ObservationIgnored let presentSubject: PassthroughSubject<Void, Never> = .init()

    /// `Publisher` that emits notification when modal should be internally presented.
    @ObservationIgnored public var presentPublisher: AnyPublisher<Void, Never> { presentSubject.eraseToAnyPublisher() }

    // MARK: Properties - Dismiss
    @ObservationIgnored let dismissSubject: PassthroughSubject</*completion:*/() -> Void, Never> = .init()

    /// `Publisher` that emits notification when modal should be internally dismissed.
    ///
    /// `Publisher` passes a completion block that must be called when animation finishes.
    @ObservationIgnored public var dismissPublisher: AnyPublisher</*completion:*/() -> Void, Never> { dismissSubject.eraseToAnyPublisher() }

    // MARK: Properties - Dimming View Tap Action
    @ObservationIgnored let dimmingViewTapActionSubject: PassthroughSubject<Void, Never> = .init()

    /// `Publisher` that emits notification when dimming view is tapped.
    ///
    /// Will only be called if `ModalPresenterRootAppearance.dimmingViewTapAction` is set to `sendActionToTopmostModal`.
    @ObservationIgnored public var dimmingViewTapActionPublisher: AnyPublisher<Void, Never> { dimmingViewTapActionSubject.eraseToAnyPublisher() }

    // MARK: Initializers
    init(
        link: ModalPresenterLink
    ) {
        self.link = link
    }
}
