//
//  BaseButtonGestureRecognizer.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if os(iOS)

import UIKit

// MARK: - Base Button Gesture Recognizer
final class BaseButtonGestureRecognizer: UIGestureRecognizer, UIGestureRecognizerDelegate {
    // MARK: Properties
    override var state: UIGestureRecognizer.State {
        get { super.state }
        set {
            guard newValue != .changed else { return } // Not needed
            
            super.state = newValue
            stateChangedHandler(.init(state: newValue))
        }
    }
    private var stateChangedHandler: (BaseButtonGestureState) -> Void
    
    private let outOfBoundsMaxOffsetToRegisterGesture: CGFloat = 10
    
    private var centerLocationOnSuperViewInitial: CGPoint?
    private let centerLocationMaxOffsetToRegisterGesture: CGFloat = 5
    
    // MARK: Initializers
    init(
        onStateChange stateChangedHandler: @escaping (BaseButtonGestureState) -> Void
    ) {
        self.stateChangedHandler = stateChangedHandler
        
        super.init(target: nil, action: nil)
        
        setUp()
        stateChangedHandler(.init(state: state)) // Setter isn't called from initializer
    }
    
    // MARK: Setup
    private func setUp() {
        delegate = self
    }
    
    // MARK: Configuration
    func setStateChangeHandler(
        to stateChangedHandler: @escaping (BaseButtonGestureState) -> Void
    ) {
        self.stateChangedHandler = stateChangedHandler
    }
    
    // MARK: Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .began
        centerLocationOnSuperViewInitial = view?.centerLocationOnSuperView
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        guard
            touchIsOnView(touches.first) == true &&
            gestureViewLocationIsUnchanged == true
        else {
            state = .cancelled
            setStateToPossibleOnNextRunLoop()
            zeroData()
            
            return
        }
        
        //state = .changed // Not needed
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        switch gestureViewLocationIsUnchanged {
        case nil, false?:
            state = .cancelled
            setStateToPossibleOnNextRunLoop()
            zeroData()
            
        case true?:
            state = .ended
            setStateToPossibleOnNextRunLoop()
            zeroData()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .cancelled
        setStateToPossibleOnNextRunLoop()
        zeroData()
    }
    
    private func setStateToPossibleOnNextRunLoop() {
        DispatchQueue.main.async(execute: {
            //state = .possible // This is set automatically in the next runLoop, but setter isn't called
            self.stateChangedHandler(.init(state: self.state))
        })
    }
    
    private func zeroData() {
        centerLocationOnSuperViewInitial = nil
    }
    
    // MARK: Gesture Recognizer Delegate
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        true
    }
    
    // MARK: Touch Detection
    private var gestureViewLocationIsUnchanged: Bool? {
        guard
            let centerLocationOnSuperViewInitial,
            let location: CGPoint = view?.centerLocationOnSuperView
        else {
            return nil
        }
        
        return location.equals(
            centerLocationOnSuperViewInitial,
            tolerance: centerLocationMaxOffsetToRegisterGesture
        )
    }
    
    private func touchIsOnView(_ touch: UITouch?) -> Bool? {
        guard let view, let touch else { return nil }
        
        return touch
            .location(in: view)
            .isOn(view.frame.size, offset: outOfBoundsMaxOffsetToRegisterGesture)
    }
}

// MARK: - Helpers
extension CGPoint {
    fileprivate func equals(_ other: CGPoint, tolerance: CGFloat) -> Bool {
        abs(x - other.x) < tolerance &&
        abs(y - other.y) < tolerance
    }
}

extension CGPoint {
    fileprivate func isOn(_ size: CGSize, offset: CGFloat) -> Bool {
        let xIsOnTarget: Bool = {
            let isPositive: Bool = x >= 0
            
            if isPositive {
                return x <= size.width + offset
            } else {
                return x >= -offset
            }
        }()
        
        let yIsOnTarget: Bool = {
            let isPositive: Bool = y >= 0
            
            if isPositive {
                return y <= size.height + offset
            } else {
                return y >= -offset
            }
        }()
        
        return xIsOnTarget && yIsOnTarget
    }
}

extension UIView {
    fileprivate var centerLocationOnSuperView: CGPoint? {
        superview?.convert(center, to: nil)
    }
}

#endif
