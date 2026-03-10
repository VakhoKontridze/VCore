//
//  View+OnInterfaceOrientationChange.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.08.23.
//

#if canImport(UIKit) && !(os(tvOS) || os(watchOS))

import SwiftUI

extension View {
    /// Adds an action to be performed when `UIInterfaceOrientation` changes.
    ///
    ///     @State private var interfaceOrientation: UIInterfaceOrientation = .unknown
    ///
    ///     var body: some View {
    ///         Text(interfaceOrientation.isLandscape ? "Landscape" : "Portrait")
    ///             .onInterfaceOrientationChange { interfaceOrientation = $0 }
    ///     }
    ///
    public func onInterfaceOrientationChange(
        action: @escaping (UIInterfaceOrientation) -> Void
    ) -> some View {
        self
            .background {
                InterfaceOrientationReaderView(
                    onChange: action
                )
                .allowsHitTesting(false) // Avoids blocking gestures
            }
    }
}

private struct InterfaceOrientationReaderView: UIViewControllerRepresentable {
    // MARK: Properties
    private let onChange: (UIInterfaceOrientation) -> Void

    // MARK: Initializers
    init(
        onChange: @escaping  (UIInterfaceOrientation) -> Void
    ) {
        self.onChange = onChange
    }

    // MARK: View Controller Representable
    func makeUIViewController(context: Context) -> _InterfaceOrientationReaderViewController {
        .init(
            onChange: onChange
        )
    }

    func updateUIViewController(_ uiViewController: _InterfaceOrientationReaderViewController, context: Context) {}
}

private final class _InterfaceOrientationReaderViewController: UIViewController {
    // MARK: Properties
    private let onChange: (UIInterfaceOrientation) -> Void
    private var lastInterfaceOrientation: UIInterfaceOrientation?

    // MARK: Initializers
    init(
        onChange: @escaping (UIInterfaceOrientation) -> Void
    ) {
        self.onChange = onChange
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Events
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)

        Task { @MainActor in
            notify()
        }
    }

    // MARK: Content Container
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        notify()
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)

        notify()
    }

    // MARK: Notification
    private func notify() {
        guard
            let interfaceOrientation: UIInterfaceOrientation = view.window?.windowScene?.interfaceOrientation,
            interfaceOrientation != lastInterfaceOrientation
        else {
            return
        }

        onChange(interfaceOrientation)

        lastInterfaceOrientation = interfaceOrientation
    }
}

#endif
