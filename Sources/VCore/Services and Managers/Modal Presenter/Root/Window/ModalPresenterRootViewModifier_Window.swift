//
//  ModalPresenterRootViewModifier_Window.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.05.25.
//

#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))

import SwiftUI
import Combine
import OSLog

struct ModalPresenterRootViewModifier_Window: ViewModifier {
    // MARK: Properties - Root
    private let root: ModalPresenterRoot
    
    // MARK: Properties - Appearance
    private let _appearance: ModalPresenterRootAppearance // Shouldn't be used directly
    
    @State private var window: UIWindow! // Unsafe
    
    // MARK: Properties - Presentation Mode
    @State private var internalPresentationMode: ModalPresenterInternalPresentationMode
    
    // MARK: Properties - Model
    @State private var model: ModalPresenterRootModel_Window
    
    // MARK: Properties - Work Manager
    @State private var workManager: ModalPresenterRootWorkManager = .init()
    
    // Delays presentation until values are read
    @State private var didReadWindow: Bool = false
    @State private var didReadSafeAreaInsets: Bool = false
    private var didReadEnvironment: Bool {
        didReadWindow &&
        didReadSafeAreaInsets
    }
    
    // MARK: Initializers
    init(
        root: ModalPresenterRoot,
        appearance: ModalPresenterRootAppearance
    ) {
        self.root = root
        
        self._appearance = appearance
        
        self._model = State(
            wrappedValue: ModalPresenterRootModel_Window(
                appearance: appearance,
                keyboardObserver: KeyboardObserver(
                    keyboardResponsivenessStrategy: appearance.keyboardResponsivenessStrategy
                )
            )
        )
        
        self._internalPresentationMode = State(
            wrappedValue: ModalPresenterInternalPresentationModeRegistrar.shared.resolve(
                key: ModalPresenterInternalPresentationModeKey(
                    root: root
                )
            )
        )
    }
    
    // MARK: Body
    func body(content: Content) -> some View {
        content
            // Reading environment
            .onMoveToWindow(action: onMoveToWindow)
            .onPlatformInterfaceOrientationChange { model.interfaceOrientation = $0 }
            .background {
                Color.clear
                    .ignoresSafeArea(.keyboard)
                    .onGeometryChange(of: { $0.safeAreaInsets }, action: onSafeAreaInsetsChange)
            }

            // Handling work
            .onReceive(internalPresentationMode.presentSubject) { workManager.addWork(.present($0)) }
            .onReceive(internalPresentationMode.updateSubject) { workManager.addWork(.update($0)) }
            .onReceive(internalPresentationMode.dismissSubject) { workManager.addWork(.dismiss($0)) }
            .onChange(of: didReadEnvironment) { workManager.setEnabledStatus(to: $1) }
            .onReceive(workManager.publisher) { workType in
                switch workType {
                case .present(let data): onReceiveInternalPresentRequest(data)
                case .update(let data): onReceiveInternalUpdateRequest(data)
                case .dismiss(let data): onReceiveInternalDismissRequest(data)
                }
            }
        
            // Syncing appearance
            .onChange(of: _appearance) { model.appearance = $1 }
    }
    
    // MARK: Actions - Internal
    private func onMoveToWindow(_ window: UIWindow) {
        guard let windowScene: UIWindowScene = window.windowScene else {
            if let rootID: String = root.rootID {
                Logger.modalPresenter.critical("Failed to extract 'UIWindowScene' from 'UIWindow' in Modal Presenter root with ID '\(rootID)'")
            } else {
                Logger.modalPresenter.critical("Failed to extract 'UIWindowScene' from 'UIWindow' in Modal Presenter root")
            }
            return
        }
        
        let hostingController: UIHostingController = .init(
            rootView: ModalPresenterRootModalContentView_Window(
                model: model
            )
        )
        hostingController.view.backgroundColor = nil
        
        let modalWindow: ModalPresenterRootWindow_Window = .init(
            windowScene: windowScene,
            model: model
        )
        modalWindow.frame = window.frame
        modalWindow.backgroundColor = nil
        modalWindow.isUserInteractionEnabled = true
        modalWindow.windowLevel = model.appearance.windowLevel
        
        modalWindow.rootViewController = hostingController
        modalWindow.isHidden = true // This flag is used to control visibility
        
        self.window = modalWindow
        
        didReadWindow = true
    }
    
    private func onSafeAreaInsetsChange(_ safeAreaInsets: EdgeInsets) {
        model.safeAreaInsets = safeAreaInsets
        
        didReadSafeAreaInsets = true
    }

    // MARK: Actions - Presentation
    private func onReceiveInternalPresentRequest(
        _ presentationData: ModalPresenterInternalPresentationMode.PresentationData
    ) {
        guard !model.modals.contains(where: { $0.id == presentationData.link.linkID }) else { return }

        let modal: ModalPresenterRootModalData_Window = .init(
            id: presentationData.link.linkID,
            appearance: presentationData.appearance,
            view: presentationData.view,
            presentationMode: ModalPresenterPresentationMode(
                linkID: presentationData.link.linkID
            )
        )

        model.modals.append(modal)
        
        window.isHidden = false

        presentationData.completion()
    }

    private func onReceiveInternalUpdateRequest(
        _ updateData: ModalPresenterInternalPresentationMode.UpdateData
    ) {
        guard let index: Int = model.modals.firstIndex(where: { $0.id == updateData.link.linkID }) else { return }

        model.modals[index].appearance = updateData.appearance
        model.modals[index].view = updateData.view
    }

    private func onReceiveInternalDismissRequest(
        _ dismissData: ModalPresenterInternalPresentationMode.DismissData
    ) {
        guard let modal: ModalPresenterRootModalData_Window = model.modals.first(where: { $0.id == dismissData.link.linkID }) else { return }

        modal.presentationMode.dismissSubject.send /*completion: */{
            model.modals.removeAll { $0.id == dismissData.link.linkID }
            
            if model.modals.isEmpty {
                window.isHidden = true
            }

            dismissData.completion()
        }
    }
}

#endif
