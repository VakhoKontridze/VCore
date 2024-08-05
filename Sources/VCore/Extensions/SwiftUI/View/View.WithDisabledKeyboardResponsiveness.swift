//
//  View.WithDisabledKeyboardResponsiveness.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.08.24.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

// MARK: - View with Disabled Keyboard Responsiveness
extension View {
    /// Disables keyboard responsiveness using `UIHostingController.overrideBehaviors(_:)` API.
    ///
    ///     @StateObject private var keyboardObserver: KeyboardObserver = .init()
    ///     @State private var text: String = ""
    ///
    ///     var body: some View {
    ///         ZStack(content: {
    ///             TextField("", text: $text)
    ///                 .textFieldStyle(.roundedBorder)
    ///                 .padding()
    ///         })
    ///         .frame(maxHeight: .infinity, alignment: .bottom)
    ///
    ///         .offset(y: -keyboardObserver.offset)
    ///         .animation(keyboardObserver.animation, value: keyboardObserver.offset)
    ///         .withDisabledKeyboardResponsiveness(regions: .keyboard)
    ///     }
    ///
    public func withDisabledKeyboardResponsiveness(
        regions: SafeAreaRegions = .all,
        edges: Edge.Set = .all
    ) -> some View {
        KeyboardResponsivenessDisablingView(content: { self })
            .ignoresSafeArea(regions, edges: edges)
    }
}

// MARK: - Keyboard Responsiveness Disabling View
private struct KeyboardResponsivenessDisablingView<Content>: UIViewControllerRepresentable where Content: View {
    // MARK: Properties
    private let content: () -> Content

    @State private var hostingController: UIHostingController<Content>?

    // MARK: Initializers
    init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
    }

    // MARK: View Controller Representable
    func makeUIViewController(context: Context) -> some UIViewController {
        let hostingController: UIHostingController = .init(rootView: content())
        hostingController.view.backgroundColor = .clear
        hostingController.overrideBehaviors([.disablesSafeAreaInsets, .disablesKeyboardAvoidance])

        DispatchQueue.main.async(execute: { self.hostingController = hostingController })

        return hostingController
    }

    func updateUIViewController(_ uiViewController: some UIViewController, context: Context) {
        hostingController?.rootView = content()
    }
}

#endif
