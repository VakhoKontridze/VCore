//
//  ModalPresenterRootModalContentView_Window.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.05.25.
//

#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))

import SwiftUI

struct ModalPresenterRootModalContentView_Window: View {
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
            ZStack {
                visualDimmingView
                
                ForEach(model.modals.enumeratedArray(), id: \.element.id) { (i, modal) in
                    let isTopmostModal: Bool = i == model.modals.count - 1
                    if isTopmostModal {
                        interactiveDimmingView(modal: modal)
                    }
                    
                    ModalPresenterRootModalView_Window(
                        onlyFocusedModalIsKeyboardResponsive: model.appearance.onlyFocusedModalIsKeyboardResponsive,
                        interfaceOrientation: model.interfaceOrientation,
                        safeAreaInsets: model.safeAreaInsets,
                        keyboardObserver: model.keyboardObserver,
                        modal: modal
                    )
                }
            }
            .apply { view in
                switch model.appearance.frame {
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
                model.modals.count == 1,
                let topmostModal: ModalPresenterRootModalData_Window = model.modals.last,
                let color: Color = topmostModal.appearance.preferredDimmingViewColor
            {
                color
                
            } else {
                model.appearance.dimmingViewColor
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
        modal: ModalPresenterRootModalData_Window
    ) -> some View {
        Color.clear
            .contentShape(.rect)
            .allowsHitTesting(model.appearance.dimmingViewTapAction.allowsHitTesting)
            .onTapGesture {
                if model.appearance.dimmingViewTapAction == .sendActionToTopmostModal {
                    modal.presentationMode.dimmingViewTapActionSubject.send()
                }
            }
    }
}

#endif
