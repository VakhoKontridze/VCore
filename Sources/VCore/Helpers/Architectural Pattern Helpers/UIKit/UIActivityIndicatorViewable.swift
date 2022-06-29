//
//  UIActivityIndicatorViewable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.10.21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Activity Indicator Viewable
/// Protocol for presenting an `UIActivityIndicatorView` and controling user interaction.
///
/// In `MVP`, `VIP`, and `VIPER` arhcitecutes, this protocol is conformed to by a `View/Controller`.
/// In `MVVM` architecture, this protocol is conformed to by a `View/Controller`.
///
///     lazy var activityIndicator: UIActivityIndicatorView = initActivityIndicator()
///
public protocol UIActivityIndicatorViewable {
    /// `UIActivityIndicator`.
    var activityIndicator: UIActivityIndicatorView { get }
    
    /// Starts `UIActivityIndicator`.
    func startActivityIndicatorAnimation()
    
    /// Stops `UIActivityIndicator`.
    func stopActivityIndicatorAnimation()
    
    /// Starts `UIActivityIndicator`, and disables user interaction.
    func startActivityIndicatorAnimationAndDisableInteraction()
    
    /// Stops `UIActivityIndicator`, and enables user interaction.
    func stopActivityIndicatorAnimationAndEnableInteraction()
}

extension UIActivityIndicatorViewable where Self: UIView {
    public func startActivityIndicatorAnimation() {
        activityIndicator.startAnimating()
    }
    
    public func stopActivityIndicatorAnimation() {
        activityIndicator.stopAnimating()
    }
    
    public func startActivityIndicatorAnimationAndDisableInteraction() {
        startActivityIndicatorAnimation()
        isUserInteractionEnabled = false
    }
    
    public func stopActivityIndicatorAnimationAndEnableInteraction() {
        stopActivityIndicatorAnimation()
        isUserInteractionEnabled = true
    }
}

extension UIActivityIndicatorViewable where Self: UIViewController {
    public func startActivityIndicatorAnimation() {
        activityIndicator.startAnimating()
    }

    public func stopActivityIndicatorAnimation() {
        activityIndicator.stopAnimating()
    }

    public func startActivityIndicatorAnimationAndDisableInteraction() {
        startActivityIndicatorAnimation()
        view.isUserInteractionEnabled = false
    }

    public func stopActivityIndicatorAnimationAndEnableInteraction() {
        stopActivityIndicatorAnimation()
        view.isUserInteractionEnabled = true
    }
}

// MARK: - Factory
extension UIView {
    /// Creates `UIActivityIndicatorView`.
    public func initActivityIndicator(
        scalingFactor: CGFloat? = nil,
        color: UIColor? = nil
    ) -> UIActivityIndicatorView {
        let activityIndicator: UIActivityIndicatorView = .init()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        activityIndicator.center = center
        if let scalingFactor = scalingFactor { activityIndicator.transform = .init(scaleX: scalingFactor, y: scalingFactor) }
        if let color = color { activityIndicator.color = color }
        
        return activityIndicator
    }
}

extension UIViewController {
    /// Creates `UIActivityIndicatorView`.
    public func initActivityIndicator(
        scalingFactor: CGFloat? = nil,
        color: UIColor? = nil
    ) -> UIActivityIndicatorView {
        view.initActivityIndicator(scalingFactor: scalingFactor, color: color)
    }
}

#endif
