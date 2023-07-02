//
//  GradientLayerUIView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.07.23.
//

#if canImport(UIKit)

import UIKit

// MARK: - Gradient Layer UI View
/// `UIView` that automatically resizes `CAGradientLayer` to it's `bounds`.
///
///     final class ViewController: UIViewController {
///         override func viewDidLoad() {
///             super.viewDidLoad()
///
///             view.backgroundColor = .systemBackground
///
///             let gradientView: GradientLayerUIView = .init()
///             gradientView.translatesAutoresizingMaskIntoConstraints = false
///             gradientView.gradientLayer.colors = [UIColor.red, UIColor.blue].map { $0.cgColor }
///
///             view.addSubview(gradientView)
///
///             NSLayoutConstraint.activate([
///                 gradientView.constraintLeading(to: view, constant: 20),
///                 gradientView.constraintTrailing(to: view, constant: -20),
///                 gradientView.constraintTop(to: view, constant: 20),
///                 gradientView.constraintBottom(to: view, constant: -20)
///             ])
///         }
///     }
///
open class GradientLayerUIView: UIView {
    // MARK: Subviews
    open var gradientLayer: CAGradientLayer = .init()

    // MARK: Initializers
    public init() {
        super.init(frame: .zero)
        setUp()
    }

    required public init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Lifecycle
    open override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    // MARK: Setup
    private func setUp() {
        addSubviews()
    }

    private func addSubviews() {
        layer.addSublayer(gradientLayer)
    }
}

#endif