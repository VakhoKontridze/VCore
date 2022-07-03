//
//  BasicAnimation.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Basic Animation
/// Wrapper on `SwiftUI`'s animation that separates curve and duration.
///
/// Duration can be used to asychronously perform an action when animation finishes.
/// To use completion handler, refer to global `withBasicAnimation(_:body:completion:)` function.
///
/// Other purpose of this model is to limit animations to basic curve and duration.
///
/// Object contains proeprty `swiftUIAnimation`, which can be used to create object that `SwiftUI` can interpret.
public struct BasicAnimation {
    /// Animation curve.
    public var curve: AnimationCurve
    
    /// Animation duration.
    public var duration: TimeInterval
    
    /// Converts `BasicAnimation` to `SwiftUI.Animation`.
    public var toSwiftUIAnimation: Animation {
        switch curve {
        case .linear: return .linear(duration: duration)
        case .easeIn: return .easeIn(duration: duration)
        case .easeOut: return .easeOut(duration: duration)
        case .easeInOut: return .easeInOut(duration: duration)
        }
    }

    // MARK: Animation Curve
    /// Enumeration that represents animation curve, suh as `linear`, `easeIn`, `easeOut`, or `easeInOut`.
    public enum AnimationCurve: Hashable, Equatable {
        // MARK: Cases
        /// Linear.
        case linear
        
        /// Ease in.
        case easeIn
        
        /// Ease out.
        case easeOut
        
        /// Ease in and out.
        case easeInOut
    }
}

// MARK: - Extension
/// Returns the result of recomputing the view's body with the provided `BasicAnimation`,
/// and optionally calls a completion handler.
///
/// Comletion handler is called using `asyncAfter`,
/// scheduling with a deadline of `.now()` `+` animation duration.
public func withBasicAnimation<Result>(
    _ animation: BasicAnimation?,
    body: () throws -> Result,
    completion: (() -> Void)?
) rethrows -> Result {
    let result: Result = try withAnimation(animation?.toSwiftUIAnimation, body)
    
    DispatchQueue.main.asyncAfter(
        deadline: .now() + (animation?.duration ?? 0),
        execute: { completion?() }
    )
    
    return result
}
