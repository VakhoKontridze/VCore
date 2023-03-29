//
//  SwiftUIGestureBaseButtonNSViewRepresentable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.03.23.
//

#if canImport(AppKit)

import SwiftUI

// MARK: - SwiftUI Gesture Base Button NS View Representable
@available(tvOS, unavailable)
struct SwiftUIGestureBaseButtonNSViewRepresentable: NSViewRepresentable {
    // MARK: Properties
    private let isEnabled: Bool
    private let stateChangeHandler: (BaseButtonGestureState) -> Void
    
    @State private var gestureRecognizer: AppKitBaseButtonGestureRecognizer?
    
    // MARK: Initializers
    init(
        isEnabled: Bool,
        onStateChange stateChangeHandler: @escaping (BaseButtonGestureState) -> Void
    ) {
        self.isEnabled = isEnabled
        self.stateChangeHandler = stateChangeHandler
    }

    // MARK: Representable
    func makeNSView(context: Context) -> NSView {
        let view: NSView = .init(frame: .zero)

        DispatchQueue.main.async(execute: {
            let gestureRecognizer: AppKitBaseButtonGestureRecognizer = .init(onStateChange: stateChangeHandler)
            self.gestureRecognizer = gestureRecognizer
            
            view.addGestureRecognizer(gestureRecognizer)
        })

        //setBindedValues(view, context: context)

        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        setBindedValues()
    }
    
    private func setBindedValues() {
        gestureRecognizer?.setStateChangeHandler(to: stateChangeHandler)
        gestureRecognizer?.isEnabled = isEnabled
    }
}

#endif
