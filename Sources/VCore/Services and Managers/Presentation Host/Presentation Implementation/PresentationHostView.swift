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
            allowsHitTests: uiModel.allowsHitTests
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
            PresentationHostGeometryReader(content: content)
                .applyModifier({
                    if #available(iOS 14.0, *) {
                        $0
                            .ignoresSafeArea(.container, edges: uiModel._ignoredContainerSafeAreaEdgesByHost)
                            .ignoresSafeArea(.keyboard, edges: uiModel._ignoredKeyboardSafeAreaEdgesByHost)
                    } else {
                        $0
                            .edgesIgnoringSafeArea(uiModel.ignoredKeyboardSafeAreaEdges)
                    }
                })
                .presentationHostPresentationMode(PresentationHostPresentationMode(
                    id: id,
                    dismiss: dismissHandler,
                    isExternallyDismissed: isExternallyDismissed,
                    externalDismissCompletion: uiViewController.dismissHostedView
                ))
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
