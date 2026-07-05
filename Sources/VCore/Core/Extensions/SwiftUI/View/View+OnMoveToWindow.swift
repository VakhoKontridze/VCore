//
//  View+OnMoveToWindow.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.08.23.
//

#if canImport(UIKit) && !os(watchOS)

public import SwiftUI

extension View {
    /// Retrieves `UIWindow` from `View`.
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .onMoveToWindow { window in
    ///                 ...
    ///             }
    ///     }
    ///
    public func onMoveToWindow(
        action: @escaping (UIWindow) -> Void
    ) -> some View {
        self
            .background {
                WindowReaderUIViewRepresentable(
                    onMoveToWindow: action
                )
                .allowsHitTesting(false) // Avoids blocking gestures
            }
    }
}

private struct WindowReaderUIViewRepresentable: UIViewRepresentable {
    // MARK: Properties
    private let onMoveToWindow: (UIWindow) -> Void

    // MARK: Initializers
    init(
        onMoveToWindow: @escaping  (UIWindow) -> Void
    ) {
        self.onMoveToWindow = onMoveToWindow
    }

    // MARK: View Representable
    func makeUIView(context: Context) -> WindowReaderUIView {
        .init(
            onMoveToWindow: onMoveToWindow
        )
    }

    func updateUIView(_ uiView: WindowReaderUIView, context: Context) {}
}

private final class WindowReaderUIView: UIView {
    // MARK: Properties
    private let onMoveToWindow: (UIWindow) -> Void
    private var lastWindowIdentifier: ObjectIdentifier?

    // MARK: Initializers
    init(
        onMoveToWindow: @escaping (UIWindow) -> Void
    ) {
        self.onMoveToWindow = onMoveToWindow
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Events
    override func didMoveToWindow() {
        super.didMoveToWindow()

        notify()
    }

    // MARK: Notification
    private func notify() {
        guard let window else { return }
        let identifier: ObjectIdentifier = .init(window)

        guard identifier != lastWindowIdentifier else { return }

        onMoveToWindow(window)

        lastWindowIdentifier = identifier
    }
}

#endif
