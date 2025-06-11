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

// MARK: - Modal Presenter Root View Modifier (Window)
struct ModalPresenterRootViewModifier_Window: ViewModifier {
    // MARK: Properties - Root
    private let root: ModalPresenterRoot
    
    // MARK: Properties - UI Model
    private let _uiModel: ModalPresenterRootUIModel // Shouldn't be used directly
    
    @State private var window: UIWindow! // Force-unwrap
    
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
        uiModel: ModalPresenterRootUIModel
    ) {
        self.root = root
        
        self._uiModel = uiModel
        
        self._model = State(
            wrappedValue: ModalPresenterRootModel_Window(
                uiModel: uiModel,
                keyboardObserver: KeyboardObserver(
                    uiModel: uiModel.keyboardObserverSubUIModel
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
            .getWindow(didReadWindow)
            .getSafeAreaInsets(ignoredKeyboardSafeAreaEdges: .all, didReadSafeAreaInsets)

            // Handling work
            .onReceive(internalPresentationMode.presentSubject) { workManager.addWork(.present($0)) }
            .onReceive(internalPresentationMode.updateSubject) { workManager.addWork(.update($0)) }
            .onReceive(internalPresentationMode.dismissSubject) { workManager.addWork(.dismiss($0)) }
            .onChange(of: didReadEnvironment) { workManager.setEnabledStatus(to: $1) }
            .onReceive(workManager.publisher) { workType in
                switch workType {
                case .present(let data): didReceiveInternalPresentRequest(data)
                case .update(let data): didReceiveInternalUpdateRequest(data)
                case .dismiss(let data): didReceiveInternalDismissRequest(data)
                }
            }
        
            // Syncing UI Model
            .onChange(of: _uiModel.frame) { model.uiModel.frame = $1 }
            .onChange(of: _uiModel.dimmingViewColor) { model.uiModel.dimmingViewColor = $1 }
            .onChange(of: _uiModel.dimmingViewTapAction) { model.uiModel.dimmingViewTapAction = $1 }
            //.onChange(of: _uiModel.keyboardObserverSubUIModel) { model.uiModel.keyboardObserverSubUIModel = $1 } // Has no effect
    }
    
    // MARK: Actions - Internal
    private func didReadWindow(_ window: UIWindow) {
        guard let windowScene: UIWindowScene = window.windowScene else {
            if let rootID: String = root.rootID {
                Logger.modalPresenter.warning("Failed to extract 'UIWindowScene' from 'UIWindow' in Modal Presenter root with ID '\(rootID)'")
            } else {
                Logger.modalPresenter.warning("Failed to extract 'UIWindowScene' from 'UIWindow' in Modal Presenter root")
            }
            return
        }
        
        let hostingController: UIHostingController = .init(
            rootView: ModalPresenterRootModalContent_Window(
                model: model
            )
        )
        hostingController.view.backgroundColor = nil
        hostingController.overrideBehaviors([.disablesSafeAreaInsets, .disablesKeyboardAvoidance])
        
        let modalWindow: ModalPresenterRootWindow_Window = .init(
            windowScene: windowScene,
            model: model
        )
        modalWindow.frame = window.frame
        modalWindow.backgroundColor = nil
        modalWindow.isUserInteractionEnabled = true
        modalWindow.windowLevel = model.uiModel.windowLevel
        
        modalWindow.rootViewController = hostingController
        modalWindow.isHidden = true // This flag is used to control visibility
        
        self.window = modalWindow
        
        didReadWindow = true
    }
    
    private func didReadSafeAreaInsets(_ safeAreaInsets: EdgeInsets) {
        model.safeAreaInsets = safeAreaInsets
        
        didReadSafeAreaInsets = true
    }

    // MARK: Actions - Presentation
    private func didReceiveInternalPresentRequest(
        _ presentationData: ModalPresenterInternalPresentationMode.PresentationData
    ) {
        guard !model.modals.contains(where: { $0.id == presentationData.link.linkID }) else { return }

        let modal: ModalPresenterRootModalData_Window = .init(
            id: presentationData.link.linkID,
            uiModel: presentationData.uiModel,
            view: presentationData.view,
            presentationMode: ModalPresenterPresentationMode(
                linkID: presentationData.link.linkID
            )
        )

        model.modals.append(modal)
        
        window.isHidden = false

        presentationData.completion()
    }

    private func didReceiveInternalUpdateRequest(
        _ updateData: ModalPresenterInternalPresentationMode.UpdateData
    ) {
        guard let index: Int = model.modals.firstIndex(where: { $0.id == updateData.link.linkID }) else { return }

        model.modals[index].uiModel = updateData.uiModel
        model.modals[index].view = updateData.view
    }

    private func didReceiveInternalDismissRequest(
        _ dismissData: ModalPresenterInternalPresentationMode.DismissData
    ) {
        guard let modal: ModalPresenterRootModalData_Window = model.modals.first(where: { $0.id == dismissData.link.linkID }) else { return }

        modal.presentationMode.dismissSubject.send /*completion: */{
            model.modals.removeAll { $0.id == dismissData.link.linkID }
                        
            ModalPresenterDataSourceCache.shared.remove(key: dismissData.link.linkID)
            
            if model.modals.isEmpty {
                window.isHidden = true
            }

            dismissData.completion()
        }
    }
}

#endif
