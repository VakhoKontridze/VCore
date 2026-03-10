//
//  SwiftUIGestureBaseButton_AppKit.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.03.23.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import SwiftUI

struct SwiftUIGestureBaseButton_AppKit: NSViewRepresentable {
    // MARK: Properties
    private let isEnabled: Bool
    private let onStateChange: (GestureBaseButtonGestureState) -> Void
    
    @State private var gestureRecognizer: AppKitBaseButtonGestureRecognizer?
    
    // MARK: Initializers
    init(
        isEnabled: Bool,
        onStateChange: @escaping (GestureBaseButtonGestureState) -> Void
    ) {
        self.isEnabled = isEnabled
        self.onStateChange = onStateChange
    }
    
    // MARK: Representable
    func makeNSView(context: Context) -> NSView {
        let view: NSView = .init(frame: .zero)
        
        Task { @MainActor in
            let gestureRecognizer: AppKitBaseButtonGestureRecognizer = .init(onStateChange: onStateChange)
            self.gestureRecognizer = gestureRecognizer
            
            view.addGestureRecognizer(gestureRecognizer)
        }
        
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        guard let gestureRecognizer else { return }
        
        gestureRecognizer.setOnStateChange(to: onStateChange)
        gestureRecognizer.isEnabled = isEnabled
    }
}

#endif
