//
//  SwiftUIGestureBaseButton_AppKit.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.03.23.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import SwiftUI

// MARK: - Swift UI Gesture Base Button (App Kit)
struct SwiftUIGestureBaseButton_AppKit: NSViewRepresentable {
    // MARK: Properties
    private let isEnabled: Bool
    private let stateChangeHandler: (GestureBaseButtonGestureState) -> Void
    
    @State private var gestureRecognizer: AppKitBaseButtonGestureRecognizer?
    
    // MARK: Initializers
    init(
        isEnabled: Bool,
        onStateChange stateChangeHandler: @escaping (GestureBaseButtonGestureState) -> Void
    ) {
        self.isEnabled = isEnabled
        self.stateChangeHandler = stateChangeHandler
    }
    
    // MARK: Representable
    func makeNSView(context: Context) -> NSView {
        let view: NSView = .init(frame: .zero)
        
        Task { @MainActor in
            let gestureRecognizer: AppKitBaseButtonGestureRecognizer = .init(onStateChange: stateChangeHandler)
            self.gestureRecognizer = gestureRecognizer
            
            view.addGestureRecognizer(gestureRecognizer)
        }
        
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        guard let gestureRecognizer else { return }
        
        gestureRecognizer.setStateChangeHandler(to: stateChangeHandler)
        gestureRecognizer.isEnabled = isEnabled
    }
}

#endif
