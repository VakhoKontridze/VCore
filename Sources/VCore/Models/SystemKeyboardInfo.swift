//
//  SystemKeyboardInfo.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

/// Contains information about software keyboard, that can be used during animations.
@available(tvOS, unavailable)
public struct SystemKeyboardInfo: Sendable {
    // MARK: Properties
    /// Keyboard’s frame at the end of its animation.
    public var frame: CGRect?
    
    /// Duration of the keyboard animation in seconds.
    public var animationDuration: TimeInterval
    
    /// Animation curve that the system uses to animate the keyboard onto or off the screen.
    public var animationOptions: UIView.AnimationOptions
    
    // MARK: Initializers
    /// Initializes `SystemKeyboardInfo` with parameters.
    public init(
        frame: CGRect?,
        animationDuration: TimeInterval,
        animationOptions: UIView.AnimationOptions
    ) {
        self.frame = frame
        self.animationDuration = animationDuration
        self.animationOptions = animationOptions
    }

    /// Initializes `SystemKeyboardInfo` with `Notification`.
    public init(
        notification: Notification
    ) {
        self.frame = {
            guard
                let rect: CGRect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            else {
                return nil
            }

            return rect
        }()

        self.animationDuration = {
            guard
                let timeInterval: TimeInterval = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
            else {
                return Self.defaultAnimationDuration
            }

            return timeInterval
        }()

        self.animationOptions = {
            guard
                let animationCurveInt: UInt = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
            else {
                return Self.defaultAnimationOptions
            }

            let animationOptions: UIView.AnimationOptions = .init(rawValue: animationCurveInt << 16)

            return animationOptions
        }()
    }
    
    // MARK: Default Values
    /// Default animation duration.
    ///
    /// If keyboard is already shown, but first responder changes, animation duration returned by the `Notification` will be `0`.
    /// In that case, this value can be used to perform additional animation.
    /// Alternately, consider checking out `nonZeroAnimationDuration`.
    public static var defaultAnimationDuration: TimeInterval { 0.25 }
    
    /// Default animation options.
    public static var defaultAnimationOptions: UIView.AnimationOptions { .init(rawValue: 7 << 16) }

    // MARK: Other Values
    /// Non-zero animation duration.
    ///
    /// If keyboard is already shown, but first responder changes, animation duration returned by the `Notification` will be `0`.
    /// In that case, this value can be used to perform additional animation.
    public var nonZeroAnimationDuration: TimeInterval {
        if animationDuration != 0 {
            animationDuration
        } else {
            Self.defaultAnimationDuration
        }
    }
}

#endif
