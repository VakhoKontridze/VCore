//
//  SystemKeyboardInfo.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - System Keyboard Info
/// Contains information about software keyboard, that can be used during animations.
@available(tvOS, unavailable)
public struct SystemKeyboardInfo {
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
        frame: CGRect,
        animationDuration: TimeInterval,
        animationOptions: UIView.AnimationOptions
    ) {
        self.frame = frame
        self.animationDuration = animationDuration
        self.animationOptions = animationOptions
    }
    
    /// Initializes `SystemKeyboardInfo` with `Notification`.
    public init(notification: Notification) {
        self.frame =
            notification.userInfo?.rect(key: UIResponder.keyboardFrameEndUserInfoKey)
        
        self.animationDuration =
            notification.userInfo?.double(key: UIResponder.keyboardAnimationDurationUserInfoKey) ??
            Self.defaultAnimationDuration
        
        self.animationOptions =
            (notification.userInfo?.uInt(key: UIResponder.keyboardAnimationCurveUserInfoKey)).map({ UIView.AnimationOptions(rawValue: $0) }) ??
            Self.defaultAnimationOptions
    }
    
    // MARK: Default Values
    /// Default animation duration. Set to `0.25`
    ///
    /// If keyboard is already shown, but first responder changes, animation duration returned by the `Notification` will be `0`.
    /// In that case, this value can be used to perform additional animation.
    /// Alternately, consider checking out `nonZeroAnimationDuration`.
    public static var defaultAnimationDuration: TimeInterval { 0.25 }
    
    /// Default animation options. Set to `curveEaseInOut`.
    public static var defaultAnimationOptions: UIView.AnimationOptions { .curveEaseInOut }
    
    // MARK: Other Values
    /// Non-zero animation duration.
    ///
    /// If keyboard is already shown, but first responder changes, animation duration returned by the `Notification` will be `0`.
    /// In that case, this value can be used to perform additional animation.
    public var nonZeroAnimationDuration: CGFloat {
        if animationDuration != 0 {
            animationDuration
        } else {
            Self.defaultAnimationDuration
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
