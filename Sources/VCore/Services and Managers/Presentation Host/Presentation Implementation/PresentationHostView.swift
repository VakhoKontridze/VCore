//
//  PresentationHostView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/14/22.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

// MARK: - Presentation Host View
@available(tvOS, unavailable)
struct PresentationHostView<Content>: UIViewControllerRepresentable where Content: View {
    // MARK: Properties
    private let id: String
    private let uiModel: PresentationHostUIModel
    private let isPresented: Binding<Bool>
    private let content: () -> Content

    @State private var wasInternallyDismissed: Bool = false

    // MARK: Initializers
    init(
        id: String,
        uiModel: PresentationHostUIModel,
        isPresented: Binding<Bool>,
        content: @escaping () -> Content
    ) {
        self.id = id
        self.uiModel = uiModel
        self.isPresented = isPresented
        self.content = content
    }

    // MARK: Representable
    func makeUIViewController(context: Context) -> UIViewController {
        PresentationHostViewController(
            id: id,
            uiModel: uiModel
        )
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        guard let uiViewController = uiViewController as? PresentationHostViewController else { fatalError() }

        let isExternallyDismissed: Bool =
            uiViewController.isPresentingView &&
            !isPresented.wrappedValue &&
            !wasInternallyDismissed

        let dismissHandler: () -> Void = {
            wasInternallyDismissed = true
            defer { DispatchQueue.main.async(execute: { wasInternallyDismissed = false }) }

            isPresented.wrappedValue = false
            uiViewController.dismissHostedView()
        }

        let content: AnyView = .init(
            PresentationHostGeometryReader(
                window: { [weak uiViewController] in uiViewController?.view.window },
                content: content
            )
            .presentationHostPresentationMode(PresentationHostPresentationMode(
                id: id,
                dismiss: dismissHandler,
                isExternallyDismissed: isExternallyDismissed,
                externalDismissCompletion: uiViewController.dismissHostedView
            ))
            .edgesIgnoringSafeArea(.all) // Additional logic is written in `UIHostingController`
        )

        if
            isPresented.wrappedValue,
            !uiViewController.isPresentingView
        {
            uiViewController.presentHostedView(content)
        }

        uiViewController.updateHostedView(with: content)
    }
}

#endif
