//
//  View.GetInterfaceOrientation.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.08.23.
//

#if os(iOS) || targetEnvironment(macCatalyst)

import SwiftUI
import UIKit

// MARK: - View Get Interface Orientation
extension View {
    /// Retrieves `UIInterfaceOrientation` from `View`.
    ///
    ///     @State private var interfaceOrientation: UIInterfaceOrientation = .unknown
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .getInterfaceOrientation({ interfaceOrientation = $0 })
    ///     }
    ///
    public func getInterfaceOrientation(
        _ action: @escaping (UIInterfaceOrientation) -> Void
    ) -> some View {
        self
            .background(content: { InterfaceOrientationReaderView(completion: action) })
    }
}

// MARK: - Interface Orientation Reader View
private struct InterfaceOrientationReaderView: UIViewControllerRepresentable {
    // MARK: Properties
    private let completion: (UIInterfaceOrientation) -> Void

    // MARK: Initializers
    init(
        completion: @escaping  (UIInterfaceOrientation) -> Void
    ) {
        self.completion = completion
    }

    // MARK: View Controller Representable
    func makeUIViewController(context: Context) -> _InterfaceOrientationReaderViewController {
        .init(completion: completion)
    }

    func updateUIViewController(_ uiViewController: _InterfaceOrientationReaderViewController, context: Context) {}
}

// MARK: - _ Interface Orientation Reader View Controller
private final class _InterfaceOrientationReaderViewController: UIViewController {
    // MARK: Properties
    private let completion: (UIInterfaceOrientation) -> Void
    private var lastInterfaceOrientation: UIInterfaceOrientation?

    // MARK: Initializers
    init(
        completion: @escaping (UIInterfaceOrientation) -> Void
    ) {
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Events
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)

        DispatchQueue.main.async(execute: notify)
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

        completion(interfaceOrientation)

        lastInterfaceOrientation = interfaceOrientation
    }
}

#endif
