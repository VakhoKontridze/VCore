//
//  UIActivityIndicatorViewable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.10.21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

/// Protocol for presenting a `UIActivityIndicatorView` and controlling user interaction.
///
///     lazy var activityIndicator: UIActivityIndicatorView = {
///         let activityIndicator: UIActivityIndicatorView = initActivityIndicator()
///         activityIndicator.translatesAutoresizingMaskIntoConstraints = false
///         return activityIndicator
///     }()
///
///     override func viewDidLoad() {
///         super.viewDidLoad()
///
///         view.addSubview(activityIndicator)
///
///         NSLayoutConstraint.activate([
///             activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
///             activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
///         ])
///
///         startActivityIndicatorAnimation()
///     }
///
///     func fetch() {
///         startActivityIndicatorAnimationAndDisableInteraction()
///
///         URLSession.shared.dataTask(with: ...) { [weak self] (data, response, error) in
///             guard let self else { return }
///
///             stopActivityIndicatorAnimationAndEnableInteraction()
///
///             ...
///         }
///     }
///
@MainActor
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

extension UIActivityIndicatorViewable {
    public func startActivityIndicatorAnimation() {
        activityIndicator.startAnimating()
    }

    public func stopActivityIndicatorAnimation() {
        activityIndicator.stopAnimating()
    }
}

extension UIActivityIndicatorViewable where Self: UIView {
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
    public func startActivityIndicatorAnimationAndDisableInteraction() {
        startActivityIndicatorAnimation()
        view.isUserInteractionEnabled = false
    }
    
    public func stopActivityIndicatorAnimationAndEnableInteraction() {
        stopActivityIndicatorAnimation()
        view.isUserInteractionEnabled = true
    }
}

extension UIView {
    /// Creates `UIActivityIndicatorView`.
    public func initActivityIndicator(
        scalingFactor: CGFloat? = nil,
        color: UIColor? = nil
    ) -> UIActivityIndicatorView {
        let activityIndicator: UIActivityIndicatorView = .init()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        scalingFactor.map { activityIndicator.transform = CGAffineTransform(scaleX: $0, y: $0) }
        color.map { activityIndicator.color = $0 }
        
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

#if DEBUG

#Preview {
    final class ViewController: UIViewController, UIActivityIndicatorViewable {
        // MARK: Properties - Subviews
        lazy var activityIndicator: UIActivityIndicatorView = {
            let activityIndicator: UIActivityIndicatorView = initActivityIndicator()
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            return activityIndicator
        }()

        // MARK: Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()

            view.addSubview(activityIndicator)
            
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            
            startActivityIndicatorAnimation()
        }
    }

    return ViewController()
}

#endif

#endif
