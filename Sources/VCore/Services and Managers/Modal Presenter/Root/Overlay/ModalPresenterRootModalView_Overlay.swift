//
//  ModalPresenterRootModalView_Overlay.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.08.25.
//

import SwiftUI

struct ModalPresenterRootModalView_Overlay: View {
    // MARK: Properties - Appearance
    private let onlyFocusedModalIsKeyboardResponsive: Bool
    private let interfaceOrientation: PlatformInterfaceOrientation
    private let safeAreaInsets: EdgeInsets
    
    // MARK: Properties - Keyboard Responsiveness
    private let keyboardObserver: KeyboardObserver
    
    @FocusState private var isFocused: Bool
    
    private var keyboardOffset: CGFloat {
        if onlyFocusedModalIsKeyboardResponsive {
            if isFocused {
                keyboardObserver.offset
            } else {
                0
            }
        } else {
            keyboardObserver.offset
        }
    }
    
    // MARK: Properties - Modal
    private let modal: ModalPresenterRootModalData_Overlay
    
    // MARK: Initializers
    init(
        onlyFocusedModalIsKeyboardResponsive: Bool,
        interfaceOrientation: PlatformInterfaceOrientation,
        safeAreaInsets: EdgeInsets,
        keyboardObserver: KeyboardObserver,
        modal: ModalPresenterRootModalData_Overlay
    ) {
        self.onlyFocusedModalIsKeyboardResponsive = onlyFocusedModalIsKeyboardResponsive
        self.interfaceOrientation = interfaceOrientation
        self.safeAreaInsets = safeAreaInsets
        self.keyboardObserver = keyboardObserver
        self.modal = modal
    }
    
    // MARK: Body
    var body: some View {
        NonInvasiveGeometryReader(alignment: modal.appearance.alignment) { geometryProxy in
            modal.view()
                .environment(\.modalPresenterInterfaceOrientation, interfaceOrientation)
                .environment(\.modalPresenterContainerSize, geometryProxy.size)
                .environment(\.modalPresenterSafeAreaInsets, safeAreaInsets)
                .environment(\.modalPresenterPresentationMode, modal.presentationMode)
            
                .focused($isFocused)
        }
        .onFirstAppear { modal.presentationMode.presentSubject.send() }
        
        // Must be written last
#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))
        .offset(y: -keyboardOffset)
        .animation(keyboardObserver.animation, value: keyboardOffset)
#endif
    }
}
