//
//  BasicAnimation.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Basic Animation
/// Animation model that stores curve and duration.
///
/// Duration can be used to asynchronously perform an action when animation finishes.
/// To use completion handler, use global `withBasicAnimation(_:body:completion:)` function.
///
/// Another purpose of this model is to limit animations to basic curve and duration.
public struct BasicAnimation {
    // MARK: Properties
    /// Animation curve.
    public var curve: AnimationCurve
    
    /// Animation duration.
    public var duration: TimeInterval
    
    // MARK: Initializers
    /// Initializes `BasicAnimation` with curve and duration.
    public init(
        curve: AnimationCurve,
        duration: TimeInterval
    ) {
        self.curve = curve
        self.duration = duration
    }

    // MARK: Animation Curve
    /// Enumeration that represents animation curve, such as `linear`, `easeIn`, `easeOut`, or `easeInOut`.
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
    
    // MARK: Casting
    /// Casts `BasicAnimation` to `SwiftUI.Animation`.
    public var toSwiftUIAnimation: Animation {
        switch curve {
        case .linear: return .linear(duration: duration)
        case .easeIn: return .easeIn(duration: duration)
        case .easeOut: return .easeOut(duration: duration)
        case .easeInOut: return .easeInOut(duration: duration)
        }
    }
}

// MARK: Casting
#if canImport(QuartzCore)

import QuartzCore

extension BasicAnimation {
    /// Casts `BasicAnimation` to `CAMediaTimingFunction`.
    public var toCAMediaTimingFunction: CAMediaTimingFunction {
        switch curve {
        case .linear: return .init(name: .linear)
        case .easeIn: return .init(name: .easeIn)
        case .easeOut: return .init(name: .easeOut)
        case .easeInOut: return .init(name: .easeInEaseOut)
        }
    }
}

#endif

#if canImport(UIKit) && !os(watchOS)

import UIKit

extension BasicAnimation {
    /// Casts `BasicAnimation` to `UIView.AnimationOptions`.
    public var toUIViewAnimationOptions: UIView.AnimationOptions {
        switch curve {
        case .linear: return .curveLinear
        case .easeIn: return .curveEaseIn
        case .easeOut: return .curveEaseOut
        case .easeInOut: return .curveEaseInOut
        }
    }
}

#endif

// MARK: - Extension
/// Returns the result of recomputing the view's body with the provided `BasicAnimation`,
/// and optionally calls a completion handler.
///
/// Completion handler is called using `asyncAfter`,
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
