//
//  ModalPresenterRootViewModifier_Overlay.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.05.25.
//

import SwiftUI
import Combine

// MARK: - Modal Presenter Root View Modifier (Overlay)
struct ModalPresenterRootViewModifier_Overlay: ViewModifier {
    // MARK: Properties - Root
    private let root: ModalPresenterRoot
    
    // MARK: Properties - UI Model
    private let uiModel: ModalPresenterRootUIModel
    
    @State private var safeAreaInsets: EdgeInsets! // Force-unwrap
    
    // MARK: Properties - Presentation Mode
    @State private var internalPresentationMode: ModalPresenterInternalPresentationMode
    
    // MARK: Properties - Work Manager
    @State private var workManager: ModalPresenterRootWorkManager = .init()
    
    // Delays presentation until values are read
    @State private var didReadSafeAreaInsets: Bool = false
    private var didReadEnvironment: Bool {
        didReadSafeAreaInsets
    }

    // MARK: Properties - Modals
    @State private var modals: [ModalPresenterRootModalData_Overlay] = []

    // MARK: Properties - Keyboard Responsiveness
#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))
    @State private var keyboardObserver: KeyboardObserver
#endif

    // MARK: Initializers
    init(
        root: ModalPresenterRoot,
        uiModel: ModalPresenterRootUIModel
    ) {
        self.root = root
        
        self.uiModel = uiModel
        
        self._internalPresentationMode = State(
            wrappedValue: ModalPresenterInternalPresentationModeRegistrar.shared.resolve(
                key: ModalPresenterInternalPresentationModeKey(
                    root: root
                )
            )
        )

#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))
        self._keyboardObserver = State(
            wrappedValue: KeyboardObserver(
                uiModel: uiModel.keyboardObserverSubUIModel
            )
        )
#endif
    }

    // MARK: Body
    func body(content: Content) -> some View {
        content
            // Reading environment
            .getSafeAreaInsets(ignoredKeyboardSafeAreaEdges: .all, didReadSafeAreaInsets)

            // UI
            .overlay(content: { layerView })
        
            // Handling work
            .onReceive(internalPresentationMode.presentSubject, perform: { workManager.addWork(.present($0)) })
            .onReceive(internalPresentationMode.updateSubject, perform: { workManager.addWork(.update($0)) })
            .onReceive(internalPresentationMode.dismissSubject, perform: { workManager.addWork(.dismiss($0)) })
            .onChange(of: didReadEnvironment, { workManager.setEnabledStatus(to: $1) })
            .onReceive(workManager.publisher, perform: { workType in
                switch workType {
                case .present(let data): didReceiveInternalPresentRequest(data)
                case .update(let data): didReceiveInternalUpdateRequest(data)
                case .dismiss(let data): didReceiveInternalDismissRequest(data)
                }
            })
    }

    @ViewBuilder
    private var layerView: some View {
        if !modals.isEmpty {
            ZStack(content: {
                visualDimmingView
                modalsView
            })
            .applyModifier({ view in
                switch uiModel.frame {
                case .fixed(let size, let alignment, let offset):
                    ZStack(content: {
                        view
                            .frame(size: size)
                            .offset(offset)
                    })
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)

                case .infinite:
                    view
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            })

            // Must be written last
#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))
            .offset(y: -keyboardObserver.offset)
            .animation(keyboardObserver.animation, value: keyboardObserver.offset)
            .ignoresSafeArea() // Using `withDisabledKeyboardResponsiveness` here disables click-through behavior
#else
            .ignoresSafeArea()
#endif
        }
    }

    private var visualDimmingView: some View {
        let color: Color = {
            if
                modals.count == 1,
                let topmostModal: ModalPresenterRootModalData_Overlay = modals.last,
                let color: Color = topmostModal.uiModel.preferredDimmingViewColor
            {
                color
                
            } else {
                uiModel.dimmingViewColor
            }
        }()
        
        return color
            .allowsHitTesting(false)
    }

    // `visualDimmingView` should not be handling gestures.
    // If two modals are presented, where top-most one is smaller,
    // the larger one behind it would be hiding most of interactive portion of the view.
    // So, it's better to insert `interactiveDimmingView` behind topmost modal.
    private func interactiveDimmingView(
        topmostModal: ModalPresenterRootModalData_Overlay
    ) -> some View {
        Color.clear
            .contentShape(.rect)
            .allowsHitTesting(uiModel.dimmingViewTapAction.allowsHitTesting)
            .onTapGesture(perform: {
                if uiModel.dimmingViewTapAction == .sendActionToTopmostModal {
                    topmostModal.presentationMode.dimmingViewTapActionSubject.send()
                }
            })
    }

    private var modalsView: some View {
        ForEach(
            modals.enumeratedArray(),
            id: \.element.id,
            content: { (i, modal) in
                modalView(
                    isTopmost: i == modals.count - 1,
                    modal: modal
                )
            }
        )
    }

    @ViewBuilder
    private func modalView(
        isTopmost: Bool,
        modal: ModalPresenterRootModalData_Overlay
    ) -> some View {
        if isTopmost {
            interactiveDimmingView(topmostModal: modal)
        }
        
        NonInvasiveGeometryReader(
            alignment: modal.uiModel.alignment,
            content: { geometryProxy in
                modal.view()
                    .environment(\.modalPresenterContainerSize, geometryProxy.size)
                    .environment(\.modalPresenterSafeAreaInsets, safeAreaInsets)
                    .environment(\.modalPresenterPresentationMode, modal.presentationMode)
            }
        )
        .onFirstAppear(perform: { modal.presentationMode.presentSubject.send() })
    }
    
    // MARK: Actions - Internal
    private func didReadSafeAreaInsets(_ safeAreaInsets: EdgeInsets) {
        self.safeAreaInsets = safeAreaInsets
        
        didReadSafeAreaInsets = true
    }

    // MARK: Actions - Presentation
    private func didReceiveInternalPresentRequest(
        _ presentationData: ModalPresenterInternalPresentationMode.PresentationData
    ) {
        guard !modals.contains(where: { $0.id == presentationData.link.linkID }) else { return }

        let modal: ModalPresenterRootModalData_Overlay = .init(
            id: presentationData.link.linkID,
            uiModel: presentationData.uiModel,
            view: presentationData.view,
            presentationMode: ModalPresenterPresentationMode(
                linkID: presentationData.link.linkID
            )
        )

        modals.append(modal)

        presentationData.completion()
    }

    private func didReceiveInternalUpdateRequest(
        _ updateData: ModalPresenterInternalPresentationMode.UpdateData
    ) {
        guard let index: Int = modals.firstIndex(where: { $0.id == updateData.link.linkID }) else { return }

        modals[index].uiModel = updateData.uiModel
        modals[index].view = updateData.view
    }

    private func didReceiveInternalDismissRequest(
        _ dismissData: ModalPresenterInternalPresentationMode.DismissData
    ) {
        guard let modal: ModalPresenterRootModalData_Overlay = modals.first(where: { $0.id == dismissData.link.linkID }) else { return }

        modal.presentationMode.dismissSubject.send(/*completion: */{
            modals.removeAll(where: { $0.id == dismissData.link.linkID })
            
            ModalPresenterDataSourceCache.shared.remove(key: dismissData.link.linkID)

            dismissData.completion()
        })
    }
}
