//
//  ModalPresenterRootModalView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.08.25.
//

import SwiftUI

struct ModalPresenterRootModalView: View {
    // MARK: Properties - Appearance
    private let onlyFocusedModalIsKeyboardResponsive: Bool
    private let interfaceOrientation: PlatformInterfaceOrientation
    private let safeAreaInsets: EdgeInsets
    
    // MARK: Properties - Keyboard Responsiveness
#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))
    
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
    
#endif
    
    // MARK: Properties - Modal
    private let modal: ModalPresenterRootModalData
    
    // MARK: Initializers
#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))
    init(
        onlyFocusedModalIsKeyboardResponsive: Bool,
        interfaceOrientation: PlatformInterfaceOrientation,
        safeAreaInsets: EdgeInsets,
        keyboardObserver: KeyboardObserver,
        modal: ModalPresenterRootModalData
    ) {
        self.onlyFocusedModalIsKeyboardResponsive = onlyFocusedModalIsKeyboardResponsive
        self.interfaceOrientation = interfaceOrientation
        self.safeAreaInsets = safeAreaInsets
        self.keyboardObserver = keyboardObserver
        self.modal = modal
    }
#else
    init(
        onlyFocusedModalIsKeyboardResponsive: Bool,
        interfaceOrientation: PlatformInterfaceOrientation,
        safeAreaInsets: EdgeInsets,
        modal: ModalPresenterRootModalData
    ) {
        self.onlyFocusedModalIsKeyboardResponsive = onlyFocusedModalIsKeyboardResponsive
        self.interfaceOrientation = interfaceOrientation
        self.safeAreaInsets = safeAreaInsets
        self.modal = modal
    }
#endif
    
    // MARK: Body
    var body: some View {
        NonInvasiveGeometryReader(alignment: modal.appearance.alignment) { geometryProxy in
            modal.view()
                .environment(modal.context)
            
                .onChange(of: interfaceOrientation, initial: true) { modal.context.interfaceOrientation = $1 }
                .onChange(of: geometryProxy.size, initial: true) { modal.context.containerSize = $1 }
                .onChange(of: safeAreaInsets, initial: true) { modal.context.safeAreaInsets = $1 }
            
#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))
                .focused($isFocused)
#endif
        }
        .onFirstAppear { modal.context.presentSubject.send() }
        
        // Must be written last
#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))
        .animation(keyboardObserver.animation, value: keyboardOffset)
        .offset(y: -keyboardOffset)
#endif
    }
}
