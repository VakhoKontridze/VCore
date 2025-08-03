//
//  ModalPresenterRootViewModifier_Overlay.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.05.25.
//

import SwiftUI
import Combine

struct ModalPresenterRootViewModifier_Overlay: ViewModifier {
    // MARK: Properties - Root
    private let root: ModalPresenterRoot
    
    // MARK: Properties - Appearance
    private let appearance: ModalPresenterRootAppearance
    
    @State private var interfaceOrientation: PlatformInterfaceOrientation = .initFromDeviceOrientation()
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
        appearance: ModalPresenterRootAppearance
    ) {
        self.root = root
        
        self.appearance = appearance
        
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
                keyboardResponsivenessStrategy: appearance.keyboardResponsivenessStrategy
            )
        )
#endif
    }

    // MARK: Body
    func body(content: Content) -> some View {
        content
            // Reading environment
            .getPlatformInterfaceOrientation { interfaceOrientation = $0 }
            .getSafeAreaInsets(ignoredKeyboardSafeAreaEdges: .all, didReadSafeAreaInsets)

            // UI
            .overlay { layerView }
        
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
    }

    @ViewBuilder
    private var layerView: some View {
        if !modals.isEmpty {
            ZStack {
                visualDimmingView
                
                ForEach(modals.enumeratedArray(), id: \.element.id) { (i, modal) in
                    let isTopmostModal: Bool = i == modals.count - 1
                    if isTopmostModal {
                        interactiveDimmingView(modal: modal)
                    }
                    
                    ModalPresenterRootModalView_Overlay(
                        onlyFocusedModalIsKeyboardResponsive: appearance.onlyFocusedModalIsKeyboardResponsive,
                        interfaceOrientation: interfaceOrientation,
                        safeAreaInsets: safeAreaInsets,
                        keyboardObserver: keyboardObserver,
                        modal: modal
                    )
                }
            }
            .apply { view in
                switch appearance.frame {
                case .fixed(let size, let alignment, let offset):
                    ZStack {
                        view
                            .frame(size: size)
                            .offset(offset)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)

                case .infinite:
                    view
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            
            // Keyboard is handled individually per modal, but this must be written at the top level.
            // Using `withDisabledKeyboardResponsiveness` here disables click-through behavior
            .ignoresSafeArea()
        }
    }

    private var visualDimmingView: some View {
        let color: Color = {
            if
                modals.count == 1,
                let topmostModal: ModalPresenterRootModalData_Overlay = modals.last,
                let color: Color = topmostModal.appearance.preferredDimmingViewColor
            {
                color
                
            } else {
                appearance.dimmingViewColor
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
        modal: ModalPresenterRootModalData_Overlay
    ) -> some View {
        Color.clear
            .contentShape(.rect)
            .allowsHitTesting(appearance.dimmingViewTapAction.allowsHitTesting)
            .onTapGesture {
                if appearance.dimmingViewTapAction == .sendActionToTopmostModal {
                    modal.presentationMode.dimmingViewTapActionSubject.send()
                }
            }
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
            appearance: presentationData.appearance,
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

        modals[index].appearance = updateData.appearance
        modals[index].view = updateData.view
    }

    private func didReceiveInternalDismissRequest(
        _ dismissData: ModalPresenterInternalPresentationMode.DismissData
    ) {
        guard let modal: ModalPresenterRootModalData_Overlay = modals.first(where: { $0.id == dismissData.link.linkID }) else { return }

        modal.presentationMode.dismissSubject.send /*completion: */{
            modals.removeAll { $0.id == dismissData.link.linkID }

            dismissData.completion()
        }
    }
}
