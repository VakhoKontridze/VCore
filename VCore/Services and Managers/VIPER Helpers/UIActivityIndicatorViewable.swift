//
//  UIActivityIndicatorViewable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.10.21.
//

import UIKit

// MARK: - UI Activity Indicator Viewable
/// Porotocl for presenting an `UIActivityIndicatorView` and controling user interraction.
///
/// In `VIP` and `VIPER` arhcitecutes, this protocol is conformed to by a `View/Controller`.
///
/// Usage example:
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
    
    /// Starts `UIActivityIndicator`, and disables user interraction.
    func startActivityIndicatorAnimationAndDisableInterraction()
    
    /// Stops `UIActivityIndicator`, and enables user interraction.
    func stopActivityIndicatorAnimationAndEnableInterraction()
}

extension UIActivityIndicatorViewable where Self: UIViewController {
    public func startActivityIndicatorAnimation() {
        activityIndicator.startAnimating()
    }
    
    public func stopActivityIndicatorAnimation() {
        activityIndicator.stopAnimating()
    }
    
    public func startActivityIndicatorAnimationAndDisableInterraction() {
        startActivityIndicatorAnimation()
        view.isUserInteractionEnabled = false
    }
    
    public func stopActivityIndicatorAnimationAndEnableInterraction() {
        stopActivityIndicatorAnimation()
        view.isUserInteractionEnabled = true
    }
}

// MARK: - Factory
extension UIViewController {
    /// Creates `UIActivityIndicatorView`
    public func initActivityIndicator(
        scalingFactor: CGFloat? = nil,
        color: UIColor? = nil
    ) -> UIActivityIndicatorView {
        let activityIndicator: UIActivityIndicatorView = .init()
        
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        if let scalingFactor = scalingFactor { activityIndicator.transform = .init(scaleX: scalingFactor, y: scalingFactor) }
        if let color = color { activityIndicator.color = color }
        
        return activityIndicator
    }
}
