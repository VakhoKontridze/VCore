//
//  ModalPresenterRootModalContent_Window.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.05.25.
//

#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))

import SwiftUI

// MARK: - Modal Presenter Root Modal Content (Window)
struct ModalPresenterRootModalContent_Window: View {
    // MARK: Properties
    private let model: ModalPresenterRootModel_Window
    
    // MARK: Initializers
    init(
        model: ModalPresenterRootModel_Window
    ) {
        self.model = model
    }
    
    // MARK: Body
    var body: some View {
        if !model.modals.isEmpty {
            ZStack(content: {
                visualDimmingView
                modalsView
            })
            .applyModifier({ view in
                switch model.uiModel.frame {
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
            .offset(y: -model.keyboardObserver.offset)
            .animation(model.keyboardObserver.animation, value: model.keyboardObserver.offset)
            .ignoresSafeArea() // Using `withDisabledKeyboardResponsiveness` here disables click-through behavior
        }
    }

    private var visualDimmingView: some View {
        let color: Color = {
            if
                model.modals.count == 1,
                let topmostModal: ModalPresenterRootModalData_Window = model.modals.last,
                let color: Color = topmostModal.uiModel.preferredDimmingViewColor
            {
                color
                
            } else {
                model.uiModel.dimmingViewColor
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
        topmostModal: ModalPresenterRootModalData_Window
    ) -> some View {
        Color.clear
            .contentShape(.rect)
            .allowsHitTesting(model.uiModel.dimmingViewTapAction.allowsHitTesting)
            .onTapGesture(perform: {
                if model.uiModel.dimmingViewTapAction == .sendActionToTopmostModal {
                    topmostModal.presentationMode.dimmingViewTapActionSubject.send()
                }
            })
    }

    private var modalsView: some View {
        ForEach(
            model.modals.enumeratedArray(),
            id: \.element.id,
            content: { (i, modal) in
                modalView(
                    isTopmost: i == model.modals.count - 1,
                    modal: modal
                )
            }
        )
    }

    @ViewBuilder
    private func modalView(
        isTopmost: Bool,
        modal: ModalPresenterRootModalData_Window
    ) -> some View {
        if isTopmost {
            interactiveDimmingView(topmostModal: modal)
        }
        
        NonInvasiveGeometryReader(
            alignment: modal.uiModel.alignment,
            content: { geometryProxy in
                modal.view()
                    .environment(\.modalPresenterContainerSize, geometryProxy.size)
                    .environment(\.modalPresenterSafeAreaInsets, model.safeAreaInsets)
                    .environment(\.modalPresenterPresentationMode, modal.presentationMode)
            }
        )
        .onFirstAppear(perform: { modal.presentationMode.presentSubject.send() })
    }
}

#endif
