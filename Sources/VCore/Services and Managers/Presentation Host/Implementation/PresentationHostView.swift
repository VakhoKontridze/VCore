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
@available(visionOS, unavailable)
struct PresentationHostView<Content>: UIViewControllerRepresentable where Content: View {
    // MARK: Properties
    private let id: String
    
    private let uiModel: PresentationHostUIModel
    
    private let isPresented: Binding<Bool>
    
    private let presentHandler: (() -> Void)?
    private let dismissHandler: (() -> Void)?
    
    private let content: () -> Content

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
            VCoreLogError("Failed to cast '\(String(describing: type(of: uiViewController)))' to 'PresentationHostViewController'")
            fatalError()
        }

        let presentationMode: PresentationHostPresentationMode = .init(
            id: id,
            dismissCompletion: { uiViewController.dismissHostedView(completion: nil) }
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
                Task.detached(operation: { @MainActor in
                    presentationMode.dismissSubject.send()
                    presentHandler?()
                })
            }

        case true:
            if !uiViewController.isPresentingViewController {
                uiViewController.presentHostedView(contentView, completion: {
                    Task.detached(operation: { @MainActor in
                        presentationMode.presentSubject.send()
                        dismissHandler?()
                    })
                })
            }
        }

        uiViewController.updateHostedView(with: contentView)
    }
}

#endif
