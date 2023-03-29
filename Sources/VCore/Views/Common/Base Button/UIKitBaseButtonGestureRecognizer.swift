//
//  UIKitBaseButtonGestureRecognizer.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UIKit Base Button Gesture Recognizer
@available(tvOS, unavailable)
final class UIKitBaseButtonGestureRecognizer: UIGestureRecognizer, UIGestureRecognizerDelegate {
    // MARK: Properties
    override var state: UIGestureRecognizer.State {
        get { super.state }
        set {
            guard newValue != .changed else { return } // Not supported
            
            super.state = newValue
            stateChangedHandler(.init(state: newValue))
        }
    }
    private var stateChangedHandler: (BaseButtonGestureState) -> Void
    
    private lazy var model: BaseButtonModel = .init(stateSetter: { [weak self] state in
        guard let self else { return }
        self.state = state
    })
    
    // MARK: Initializers
    init(
        onStateChange stateChangedHandler: @escaping (BaseButtonGestureState) -> Void
    ) {
        self.stateChangedHandler = stateChangedHandler
        
        super.init(target: nil, action: nil)
        
        delegate = self
        stateChangedHandler(.init(state: state)) // Setter isn't called from initializer
    }
    
    // MARK: Configuration
    func setStateChangeHandler(
        to stateChangedHandler: @escaping (BaseButtonGestureState) -> Void
    ) {
        self.stateChangedHandler = stateChangedHandler
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

// MARK: - Helpers
extension UIView {
    fileprivate var centerLocationOnSuperView: CGPoint? {
        superview?.convert(center, to: nil)
    }
}

#endif
