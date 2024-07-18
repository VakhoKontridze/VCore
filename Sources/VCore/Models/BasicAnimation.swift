//
//  BasicAnimation.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - Basic Animation
/// Wrapper for `SwiftUI`'s native `Animation` that stores curve and duration.
///
/// Duration can be used to asynchronously perform an action when animation finishes.
/// To use completion handler, use global `withBasicAnimation(_:body:completion:)` function.
///
/// Another purpose of this model is to limit animations to basic curve and duration.
///
///     withAnimation(
///         BasicAnimation(curve: .easeIn, duration: 1).toSwiftUIAnimation,
///         { ... }
///     )
///
///     withBasicAnimation(
///         BasicAnimation(curve: .easeIn, duration: 1),
///         body: { ... },
///         completion: { ... }
///     )
///
public struct BasicAnimation {
    // MARK: Properties
    /// Animation curve.
    public var curve: AnimationCurve
    
    /// Animation duration.
    public var duration: TimeInterval

    /// Animation delay.
    public var delay: TimeInterval
    
    // MARK: Initializers
    /// Initializes `BasicAnimation` with curve and duration.
    public init(
        curve: AnimationCurve,
        duration: TimeInterval,
        delay: TimeInterval = 0
    ) {
        self.curve = curve
        self.duration = duration
        self.delay = delay
    }
    
    // MARK: Animation Curve
    /// Animation curve.
    public enum AnimationCurve: Int, Equatable, Hashable, CaseIterable {
        /// Linear.
        case linear
        
        /// Ease in.
        case easeIn
        
        /// Ease out.
        case easeOut
        
        /// Ease in and out.
        case easeInOut
    }
    
    // MARK: Mapping
    /// Converts `BasicAnimation` to `SwiftUI.Animation`.
    public var toSwiftUIAnimation: Animation {
        switch curve {
        case .linear: Animation.linear(duration: duration).delay(delay)
        case .easeIn: Animation.easeIn(duration: duration).delay(delay)
        case .easeOut: Animation.easeOut(duration: duration).delay(delay)
        case .easeInOut: Animation.easeInOut(duration: duration).delay(delay)
        }
    }
}

// MARK: - Casting
#if canImport(QuartzCore)

import QuartzCore

extension BasicAnimation {
    /// Converts `BasicAnimation` to `CAMediaTimingFunction`.
    public var toCAMediaTimingFunction: CAMediaTimingFunction {
        switch curve {
        case .linear: CAMediaTimingFunction(name: .linear)
        case .easeIn: CAMediaTimingFunction(name: .easeIn)
        case .easeOut: CAMediaTimingFunction(name: .easeOut)
        case .easeInOut: CAMediaTimingFunction(name: .easeInEaseOut)
        }
    }
}

#endif

#if canImport(UIKit) && !os(watchOS)

import UIKit

extension BasicAnimation {
    /// Converts `BasicAnimation` to `UIView.AnimationOptions`.
    public var toUIViewAnimationOptions: UIView.AnimationOptions {
        switch curve {
        case .linear: .curveLinear
        case .easeIn: .curveEaseIn
        case .easeOut: .curveEaseOut
        case .easeInOut: .curveEaseInOut
        }
    }
}

#endif

// MARK: - Function
/// Returns the result of recomputing the view's body with the provided `BasicAnimation`,
/// and optionally calls a completion handler.
///
/// Completion handler is called using `asyncAfter`,
/// scheduling with a deadline of `.now()` `+` animation duration.
///
///     withBasicAnimation(
///         BasicAnimation(curve: .easeIn, duration: 1),
///         body: { ... },
///         completion: { ... }
///     )
///
public func withBasicAnimation<Result>( // TODO: iOS 17.0 - Remove
    _ animation: BasicAnimation?,
    body: () throws -> Result,
    completion: (() -> Void)?
) rethrows -> Result {
    let result: Result = try withAnimation(animation?.toSwiftUIAnimation, body)
    
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + (animation?.delay ?? 0) + (animation?.duration ?? 0),
        execute: { completion?() }
    )
    
    return result
}
