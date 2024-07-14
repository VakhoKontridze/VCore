//
//  View.GetWindow.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.08.23.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

// MARK: - View Get Window
extension View {
    /// Retrieves `UIWindow` from `View`.
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .getWindow({ window in
    ///                 ...
    ///             })
    ///     }
    ///
    public func getWindow(
        _ action: @escaping (UIWindow) -> Void
    ) -> some View {
        self
            .background(content: {
                WindowReaderView(
                    completion: action
                )
                .allowsHitTesting(false) // Avoids blocking gestures
            })
    }
}

// MARK: - Window Reader View
private struct WindowReaderView: UIViewRepresentable {
    // MARK: Properties
    private let completion: (UIWindow) -> Void

    // MARK: Initializers
    init(
        completion: @escaping  (UIWindow) -> Void
    ) {
        self.completion = completion
    }

    // MARK: View Representable
    func makeUIView(context: Context) -> _WindowReaderView {
        .init(completion: completion)
    }

    func updateUIView(_ uiView: _WindowReaderView, context: Context) {}
}

// MARK: - _ Window Reader View
private final class _WindowReaderView: UIView {
    // MARK: Properties
    private let completion: (UIWindow) -> Void
    private var lastWindowIdentifier: ObjectIdentifier?

    // MARK: Initializers
    init(
        completion: @escaping (UIWindow) -> Void
    ) {
        self.completion = completion
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Events
    override func didMoveToWindow() {
        super.didMoveToWindow()

        DispatchQueue.main.async(execute: notify)
    }

    // MARK: Notification
    private func notify() {
        guard let window else { return }
        let identifier: ObjectIdentifier = .init(window)

        guard identifier != lastWindowIdentifier else { return }

        completion(window)

        lastWindowIdentifier = identifier
    }
}

#endif
