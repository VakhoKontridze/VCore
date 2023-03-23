//
//  SwiftUIBaseButtonUIViewRepresentable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

// MARK: - Swift UI Base Button UI View Representable
@available(tvOS, unavailable)
struct SwiftUIBaseButtonUIViewRepresentable: UIViewRepresentable {
    // MARK: Properties
    private let isEnabled: Bool
    private let stateChangeHandler: (BaseButtonGestureState) -> Void
    
    @State private var gestureRecognizer: UIKitBaseButtonGestureRecognizer?
    
    // MARK: Initializers
    init(
        isEnabled: Bool,
        onStateChange stateChangeHandler: @escaping (BaseButtonGestureState) -> Void
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
        setBindedValues()
    }
    
    private func setBindedValues() {
        gestureRecognizer?.setStateChangeHandler(to: stateChangeHandler)
        gestureRecognizer?.isEnabled = isEnabled
    }
}

#endif