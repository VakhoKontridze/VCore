//
//  GradientLayerUIView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.07.23.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Gradient Layer UI View
/// `UIView` that automatically resizes `CAGradientLayer` to it's `bounds`.
///
///     final class ViewController: UIViewController {
///         override func viewDidLoad() {
///             super.viewDidLoad()
///
///             view.backgroundColor = UIColor.systemBackground
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
open class GradientLayerUIView: UIView, Sendable {
    // MARK: Subviews
    open var gradientLayer: CAGradientLayer = .init()

    // MARK: Initializers
    public init() {
        super.init(frame: .zero)
        setUp()
    }

    @available(*, unavailable)
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

// MARK: - Preview
#if DEBUG

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview(body: {
    let view: GradientLayerUIView = .init()
    view.gradientLayer.colors = [UIColor.red, UIColor.blue].map { $0.cgColor }

    return view
})

#endif

#endif
