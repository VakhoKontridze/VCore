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
    private let gestureHandler: (BaseButtonGestureState) -> Void
    
    @State private var gestureRecognizer: BaseButtonTapGestureRecognizer?
    
    // MARK: Initializers
    init(
        isEnabled: Bool,
        gesture gestureHandler: @escaping (BaseButtonGestureState) -> Void
    ) {
        self.isEnabled = isEnabled
        self.gestureHandler = gestureHandler
    }

    // MARK: Representable
    func makeUIView(context: Context) -> UIView {
        let view: UIView = .init(frame: .zero)
        
        DispatchQueue.main.async(execute: {
            let gestureRecognizer: BaseButtonTapGestureRecognizer = .init(gesture: gestureHandler)
            
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
        
        gestureRecognizer?.update(gesture: gestureHandler)
    }
}

#endif
