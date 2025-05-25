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
/// Purpose of this model is to limit animations to basic curve and duration.
///
///     withAnimation(
///         BasicAnimation(curve: .easeIn, duration: 1).toSwiftUIAnimation,
///         { ... },
///         completion: { ... }
///     )
///
public struct BasicAnimation: Sendable {
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
    public enum AnimationCurve: Int, Equatable, Hashable, Sendable, CaseIterable {
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

@available(watchOS, unavailable)
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
