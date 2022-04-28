//
//  SystemKeyboardInfo.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if os(iOS)

import UIKit

// MARK: - System Keyboard Info
/// Contains information about software keyboard.
public struct SystemKeyboardInfo {
    // MARK: Properties
    /// Keyboard’s frame at the end of its animation.
    public let frame: CGRect
    
    /// Duration of the keyboard animation in seconds.
    public let animationDuration: TimeInterval
    
    /// Animation curve that the system uses to animate the keyboard onto or off the screen.
    public let animationOptions: UIView.AnimationOptions
    
    // MARK: Initializers
    init(notification: Notification) {
        self.frame =
            notification.userInfo?.rect(key: UIResponder.keyboardFrameEndUserInfoKey) ??
            Self.estimatedKeyboardFrame
        
        self.animationDuration =
            notification.userInfo?.double(key: UIResponder.keyboardAnimationDurationUserInfoKey) ??
            0.25
        
        self.animationOptions =
            (notification.userInfo?.uInt(key: UIResponder.keyboardAnimationCurveUserInfoKey)).map { .init(rawValue: $0) } ??
            .curveLinear
    }
    
    // MARK: Helpers
    private static var estimatedKeyboardFrame: CGRect {
        let estimatedKeyboardHeight: CGFloat = 400
        
        return .init(
            x: 0,
            y: UIScreen.main.bounds.height - estimatedKeyboardHeight,
            width: UIScreen.main.bounds.width,
            height: estimatedKeyboardHeight
        )
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
