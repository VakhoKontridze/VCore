//
//  ModalPresenterRootViewModifier.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.05.25.
//

import SwiftUI
import Combine

struct ModalPresenterRootViewModifier: ViewModifier {
    // MARK: Properties - Root
    private let root: ModalPresenterRoot
    
    // MARK: Properties - Appearance
    private let appearance: ModalPresenterRootAppearance
    
    @State private var interfaceOrientation: PlatformInterfaceOrientation = .initFromDeviceOrientation()
    @State private var safeAreaInsets: EdgeInsets = .init()
    
    // MARK: Properties - Context
    @State private var internalContext: ModalPresenterInternalContext
    
    // MARK: Properties - Work Manager
    @State private var workManager: ModalPresenterRootWorkManager = .init()
    
    // Delays presentation until values are read
    @State private var didReadSafeAreaInsets: Bool = false
    private var didReadEnvironment: Bool {
        didReadSafeAreaInsets
    }

    // MARK: Properties - Modals
    @State private var modals: [ModalPresenterRootModalData] = []

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
        
        self._internalContext = State(
            wrappedValue: ModalPresenterInternalContextRegistrar.shared.resolve(
                key: ModalPresenterInternalContextKey(
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
            .onPlatformInterfaceOrientationChange { interfaceOrientation = $0 }
            .background {
                Color.clear
                    .ignoresSafeArea(.keyboard)
                    .onGeometryChange(of: { $0.safeAreaInsets }, action: onSafeAreaInsetsChange)
            }

            // UI
            .overlay { layerView }
        
            // Handling work
            .onReceive(internalContext.presentSubject) { workManager.addWork(.present($0)) }
            .onReceive(internalContext.updateSubject) { workManager.addWork(.update($0)) }
            .onReceive(internalContext.dismissSubject) { workManager.addWork(.dismiss($0)) }
            .onChange(of: didReadEnvironment) { workManager.setEnabledStatus(to: $1) }
            .onReceive(workManager.publisher) { workType in
                switch workType {
                case .present(let data): onReceiveInternalPresentRequest(data)
                case .update(let data): onReceiveInternalUpdateRequest(data)
                case .dismiss(let data): onReceiveInternalDismissRequest(data)
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
                    
#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))
                    ModalPresenterRootModalView(
                        onlyFocusedModalIsKeyboardResponsive: appearance.onlyFocusedModalIsKeyboardResponsive,
                        interfaceOrientation: interfaceOrientation,
                        safeAreaInsets: safeAreaInsets,
                        keyboardObserver: keyboardObserver,
                        modal: modal
                    )
#else
                    ModalPresenterRootModalView(
                        onlyFocusedModalIsKeyboardResponsive: appearance.onlyFocusedModalIsKeyboardResponsive,
                        interfaceOrientation: interfaceOrientation,
                        safeAreaInsets: safeAreaInsets,
                        modal: modal
                    )
#endif
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
            .ignoresSafeArea()
        }
    }

    private var visualDimmingView: some View {
        let color: Color = {
            if
                modals.count == 1,
                let topmostModal: ModalPresenterRootModalData = modals.last,
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
        modal: ModalPresenterRootModalData
    ) -> some View {
        Color.clear
            .contentShape(.rect)
            .allowsHitTesting(appearance.dimmingViewTapAction.allowsHitTesting)
            .onTapGesture {
                if appearance.dimmingViewTapAction == .sendActionToTopmostModal {
                    modal.context.dimmingViewTapActionSubject.send()
                }
            }
    }
    
    // MARK: Actions - Internal
    private func onSafeAreaInsetsChange(_ safeAreaInsets: EdgeInsets) {
        self.safeAreaInsets = safeAreaInsets
        
        didReadSafeAreaInsets = true
    }

    // MARK: Actions - Presentation
    private func onReceiveInternalPresentRequest(
        _ presentationData: ModalPresenterInternalContext.PresentationData
    ) {
        guard !modals.contains(where: { $0.id == presentationData.link.linkID }) else { return }

        let modal: ModalPresenterRootModalData = .init(
            id: presentationData.link.linkID,
            appearance: presentationData.appearance,
            view: presentationData.view,
            context: ModalPresenterContext(
                link: presentationData.link
            )
        )

        modals.append(modal)

        presentationData.completion()
    }

    private func onReceiveInternalUpdateRequest(
        _ updateData: ModalPresenterInternalContext.UpdateData
    ) {
        guard let index: Int = modals.firstIndex(where: { $0.id == updateData.link.linkID }) else { return }

        modals[index].appearance = updateData.appearance
        modals[index].view = updateData.view
    }

    private func onReceiveInternalDismissRequest(
        _ dismissData: ModalPresenterInternalContext.DismissData
    ) {
        guard let modal: ModalPresenterRootModalData = modals.first(where: { $0.id == dismissData.link.linkID }) else { return }

        modal.context.dismissSubject.send /*completion: */{
            modals.removeAll { $0.id == dismissData.link.linkID }

            dismissData.completion()
        }
    }
}
