//
//  UIKitBaseButtonGestureRecognizer.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

@available(tvOS, unavailable)
final class UIKitBaseButtonGestureRecognizer: UIGestureRecognizer, UIGestureRecognizerDelegate {
    // MARK: Properties
    override var state: UIGestureRecognizer.State {
        get { super.state }
        set {
            guard newValue != .changed else { return } // Not used
            
            super.state = newValue
            onStateChange(GestureBaseButtonGestureState(state: newValue))
        }
    }
    private var onStateChange: (GestureBaseButtonGestureState) -> Void
    
    private lazy var model: GestureBaseButtonModel = .init(
        stateSetter: { [weak self] in self?.state = $0 }
    )
    
    // MARK: Initializers
    init(
        onStateChange: @escaping (GestureBaseButtonGestureState) -> Void
    ) {
        self.onStateChange = onStateChange
        
        super.init(target: nil, action: nil)
        
        delegate = self
    }
    
    // MARK: Configuration
    func setOnStateChange(
        to onStateChange: @escaping (GestureBaseButtonGestureState) -> Void
    ) {
        self.onStateChange = onStateChange
    }
    
    // MARK: Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let view else { return }
        
        state = model.began(
            centerLocationOnSuperView: view.centerLocationOnSuperView
        )
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let view else { return }
        
        if let state = model.changed(
            viewSize: view.frame.size,
            centerLocationOnSuperView: view.centerLocationOnSuperView,
            location: location(in: view)
        ) {
            self.state = state
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let view else { return }
        
        state = model.ended(
            centerLocationOnSuperView: view.centerLocationOnSuperView
        )
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        state = model.cancelled()
    }
    
    // MARK: Gesture Recognizer Delegate
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        true
    }
}

extension UIView {
    fileprivate var centerLocationOnSuperView: CGPoint? {
        superview?.convert(center, to: nil)
    }
}

#endif
