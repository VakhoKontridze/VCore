//
//  SwiftUIBaseButtonViewRepresentable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if os(iOS)

import SwiftUI

// MARK: - Swift UI Base Button View Representable
struct SwiftUIBaseButtonViewRepresentable: UIViewRepresentable {
    // MARK: Properties
    private let isEnabled: Bool
    private let stateChangeHandler: (BaseButtonGestureState) -> Void
    
    @State private var gestureRecognizer: BaseButtonGestureRecognizer?
    
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
            let gestureRecognizer: BaseButtonGestureRecognizer = .init(onStateChange: stateChangeHandler)
            
            self.gestureRecognizer = gestureRecognizer
            view.addGestureRecognizer(gestureRecognizer)
        })
        
        //setBindedValues(view, context: context)
        
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        setBindedValues(uiView, context: context)
    }
    
    private func setBindedValues(_ view: UIView, context: Context) {
        view.isUserInteractionEnabled = isEnabled
        
        gestureRecognizer?.setStateChangeHandler(to: stateChangeHandler)
    }
}

#endif
