//
//  SystemKeyboardInfo.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if os(iOS)

import UIKit

// MARK: - System Keyboard Info
/// Contains information about software keyboard, that can be used during animations.
public struct SystemKeyboardInfo {
    // MARK: Properties
    /// Keyboard’s frame at the end of its animation.
    public var frame: CGRect
    
    /// Duration of the keyboard animation in seconds.
    public var animationDuration: TimeInterval
    
    /// Animation curve that the system uses to animate the keyboard onto or off the screen.
    public var animationOptions: UIView.AnimationOptions
    
    // MARK: Initializers
    /// Initializes `SystemKeyboardInfo` with parameters.
    public init(frame: CGRect, animationDuration: TimeInterval, animationOptions: UIView.AnimationOptions) {
        self.frame = frame
        self.animationDuration = animationDuration
        self.animationOptions = animationOptions
    }
    
    /// Initializes `SystemKeyboardInfo` with `Notification`.
    public init(notification: Notification) {
        self.frame =
            notification.userInfo?.rect(key: UIResponder.keyboardFrameEndUserInfoKey) ??
            Self.defaultEstimatedKeyboardFrame
        
        self.animationDuration =
            notification.userInfo?.double(key: UIResponder.keyboardAnimationDurationUserInfoKey) ??
            Self.defaultAnimationDuration
        
        self.animationOptions =
            (notification.userInfo?.uInt(key: UIResponder.keyboardAnimationCurveUserInfoKey)).map { .init(rawValue: $0) } ??
            Self.defaultAnimationOptions
    }
    
    // MARK: Default Values
    /// Default estimated keyboard frame. Defaults to screen width times `400` points positioned on the bottom.
    public static var defaultEstimatedKeyboardFrame: CGRect {
        let estimatedKeyboardHeight: CGFloat = 400
        
        return .init(
            x: 0,
            y: UIScreen.main.bounds.height - estimatedKeyboardHeight,
            width: UIScreen.main.bounds.width,
            height: estimatedKeyboardHeight
        )
    }
    
    /// Default animation duration. Defaults to `0.25`
    ///
    /// If keyboard is already shown, but first responder changes, animation duration returned by the `Notification` will be `0`.
    /// In that case, this value can be used to perform additional animation.
    /// Alternately, consider checking out `nonZeroAnimationDuration`.
    public static var defaultAnimationDuration: TimeInterval { 0.25 }
    
    /// Default animation options. Defaults to `curveLinear`.
    public static var defaultAnimationOptions: UIView.AnimationOptions { .curveLinear }
    
    // MARK: Other Values
    /// Non-zero animation duration.
    ///
    /// If keyboard is already shown, but first responder changes, animation duration returned by the `Notification` will be `0`.
    /// In that case, this value can be used to perform additional animation.
    public var nonZeroAnimationDuration: CGFloat {
        if animationDuration != 0 {
            return animationDuration
        } else {
            return Self.defaultAnimationDuration
        }
    }
}

// MARK: - Helpers
extension Dictionary where Key == AnyHashable, Value == Any {
    fileprivate func uInt(key: String) -> UInt? {
        (self[key] as? NSNumber)?.uintValue
    }
    
    fileprivate func double(key: String) -> Double? {
        (self[key] as? NSNumber)?.doubleValue
    }
    
    fileprivate func rect(key: String) -> CGRect? {
        (self[key] as? NSValue)?.cgRectValue
    }
}

#endif
