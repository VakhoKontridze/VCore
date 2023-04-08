//
//  GestureBaseButtonModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.03.23.
//

#if !os(watchOS)

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - Gesture Base Button Model
final class GestureBaseButtonModel {
    // MARK: Properties
    private let outOfBoundsMaxOffsetToRegisterGesture: CGFloat = 10
    
    private var centerLocationOnSuperViewInitial: CGPoint?
    private let centerLocationMaxOffsetToRegisterGesture: CGFloat = 5
    
    private let stateSetter: (GestureRecognizerState) -> Void
    
    // MARK: Initializers
    init(stateSetter: @escaping (GestureRecognizerState) -> Void) {
        self.stateSetter = stateSetter
    }
    
    // MARK: Gesture Recognizer State
#if canImport(UIKit)
    typealias GestureRecognizerState = UIGestureRecognizer.State
#elseif canImport(AppKit)
    typealias GestureRecognizerState = NSGestureRecognizer.State
#endif
    
    // MARK: Touches
    func began(
        centerLocationOnSuperView: CGPoint?
    ) -> GestureRecognizerState {
        self.centerLocationOnSuperViewInitial = centerLocationOnSuperView
        
        return .began
    }
    
    func changed(
        viewSize: CGSize,
        centerLocationOnSuperView: CGPoint?,
        location: CGPoint?
    ) -> GestureRecognizerState? {
        guard
            let location,
            location.isOn(viewSize, offset: outOfBoundsMaxOffsetToRegisterGesture) &&
                gestureViewLocationIsUnchanged(centerLocationOnSuperView) == true
        else {
            defer { zeroData() }
            
            setStateToPossibleOnNextRunLoop()
            return .cancelled
        }
        
        //state = .changed // Not needed
        return nil
    }
    
    func ended(
        centerLocationOnSuperView: CGPoint?
    ) -> GestureRecognizerState {
        defer { zeroData() }
        
        setStateToPossibleOnNextRunLoop()
        if gestureViewLocationIsUnchanged(centerLocationOnSuperView) == true {
            return .ended
        } else {
            return .cancelled
        }
    }
    
    func cancelled() -> GestureRecognizerState {
        defer { zeroData() }
        
        setStateToPossibleOnNextRunLoop()
        return .cancelled
    }
    
    private func zeroData() {
        centerLocationOnSuperViewInitial = nil
    }
    
    private func setStateToPossibleOnNextRunLoop() {
        DispatchQueue.main.async(execute: {
            // This is set automatically in the next runLoop, but setter isn't called
            self.stateSetter(.possible)
        })
    }
    
    // MARK: Touch Detection
    private func gestureViewLocationIsUnchanged(
        _ centerLocationOnSuperView: CGPoint?
    ) -> Bool? {
        guard
            let initial = centerLocationOnSuperViewInitial,
            let final: CGPoint = centerLocationOnSuperView
        else {
            return nil
        }
        
        return final.equals(
            initial,
            tolerance: centerLocationMaxOffsetToRegisterGesture
        )
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

#endif
