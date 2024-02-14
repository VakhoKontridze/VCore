//
//  PresentationHostView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/14/22.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI
import Combine
import OSLog

// MARK: - Presentation Host View
@available(tvOS, unavailable)
@available(visionOS, unavailable)
struct PresentationHostView<Content>: UIViewControllerRepresentable where Content: View {
    // MARK: Properties
    private let id: String
    
    private let uiModel: PresentationHostUIModel
    
    private let isPresented: Binding<Bool>
    
    private let presentHandler: (() -> Void)?
    private let dismissHandler: (() -> Void)?
    
    private let content: () -> Content

    // Subjects needs to be stores here and persisted, since they are `class` types
    @State private var presentSubject: PassthroughSubject<Void, Never> = .init()
    @State private var dismissSubject: PassthroughSubject<Void, Never> = .init()

    // MARK: Initializers
    init(
        id: String,
        uiModel: PresentationHostUIModel,
        isPresented: Binding<Bool>,
        onPresent presentHandler: (() -> Void)?,
        onDismiss dismissHandler: (() -> Void)?,
        content: @escaping () -> Content
    ) {
        self.id = id
        self.uiModel = uiModel
        self.isPresented = isPresented
        self.presentHandler = presentHandler
        self.dismissHandler = dismissHandler
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
        guard let uiViewController = uiViewController as? PresentationHostViewController else {
            Logger.presentationHost.critical("Failed to cast '\(uiViewController.debugDescription)' to 'PresentationHostViewController' in 'PresentationHost'")
            fatalError()
        }

        let presentationMode: PresentationHostPresentationMode = .init(
            id: id,
            presentPublisher: presentSubject.eraseToAnyPublisher(),
            dismissPublisher: dismissSubject.eraseToAnyPublisher(),
            dismissCompletion: {
                uiViewController.dismissHostedView(completion: {
                    dismissHandler?()
                })
            }
        )

        let contentView: AnyView = PresentationHostGeometryReader(
            window: { [weak uiViewController] in uiViewController?.view.window },
            content: content
        )
        .presentationHostPresentationMode(presentationMode)
        .eraseToAnyView()

        switch isPresented.wrappedValue {
        case false:
            if uiViewController.isPresentingViewController {
                Task(operation: { @MainActor in
                    dismissSubject.send()
                })
            }

        case true:
            // `uiViewController.isPresentingViewController` isn't checked, since it'll be handled internally
            uiViewController.presentHostedView(contentView, completion: {
                Task(operation: { @MainActor in
                    presentSubject.send()
                    presentHandler?()
                })
            })
        }

        uiViewController.updateHostedView(with: contentView)
    }
}

#endif
