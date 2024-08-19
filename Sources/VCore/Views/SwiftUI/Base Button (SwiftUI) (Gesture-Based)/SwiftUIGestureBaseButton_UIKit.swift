//
//  SwiftUIGestureBaseButton_UIKit.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

// MARK: - Swift UI Gesture Base Button (UI Kit)
@available(tvOS, unavailable)
struct SwiftUIGestureBaseButton_UIKit: UIViewRepresentable {
    // MARK: Properties
    private let isEnabled: Bool
    private let stateChangeHandler: (GestureBaseButtonGestureState) -> Void
    
    @State private var gestureRecognizer: UIKitBaseButtonGestureRecognizer?
    
    // MARK: Initializers
    init(
        isEnabled: Bool,
        onStateChange stateChangeHandler: @escaping (GestureBaseButtonGestureState) -> Void
    ) {
        self.isEnabled = isEnabled
        self.stateChangeHandler = stateChangeHandler
    }
    
    // MARK: Representable
    func makeUIView(context: Context) -> UIView {
        let view: UIView = .init(frame: .zero)
        
        DispatchQueue.main.async(execute: {
            let gestureRecognizer: UIKitBaseButtonGestureRecognizer = .init(onStateChange: stateChangeHandler)
            self.gestureRecognizer = gestureRecognizer
            
            view.addGestureRecognizer(gestureRecognizer)
        })
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let gestureRecognizer else { return }
        
        gestureRecognizer.setStateChangeHandler(to: stateChangeHandler)
        gestureRecognizer.isEnabled = isEnabled
    }
}

#endif
