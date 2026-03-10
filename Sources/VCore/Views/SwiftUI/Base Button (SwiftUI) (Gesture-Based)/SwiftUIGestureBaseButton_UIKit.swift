//
//  SwiftUIGestureBaseButton_UIKit.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

@available(tvOS, unavailable)
struct SwiftUIGestureBaseButton_UIKit: UIViewRepresentable {
    // MARK: Properties
    private let isEnabled: Bool
    private let onStateChange: (GestureBaseButtonGestureState) -> Void
    
    @State private var gestureRecognizer: UIKitBaseButtonGestureRecognizer?
    
    // MARK: Initializers
    init(
        isEnabled: Bool,
        onStateChange: @escaping (GestureBaseButtonGestureState) -> Void
    ) {
        self.isEnabled = isEnabled
        self.onStateChange = onStateChange
    }
    
    // MARK: Representable
    func makeUIView(context: Context) -> UIView {
        let view: UIView = .init(frame: .zero)
        
        Task { @MainActor in
            let gestureRecognizer: UIKitBaseButtonGestureRecognizer = .init(onStateChange: onStateChange)
            self.gestureRecognizer = gestureRecognizer
            
            view.addGestureRecognizer(gestureRecognizer)
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let gestureRecognizer else { return }
        
        gestureRecognizer.setOnStateChange(to: onStateChange)
        gestureRecognizer.isEnabled = isEnabled
    }
}

#endif
