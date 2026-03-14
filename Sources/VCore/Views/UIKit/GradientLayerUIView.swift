//
//  GradientLayerUIView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.07.23.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

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
///                 gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
///                 gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
///                 gradientView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
///                 gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
///             ])
///         }
///     }
///
open class GradientLayerUIView: UIView {
    // MARK: Properties - Subviews
    /// Gradient layer.
    open private(set) var gradientLayer: CAGradientLayer = .init()

    // MARK: Initializers
    /// Initializes `GradientLayerUIView`.
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

#if DEBUG

#Preview {
    let view: GradientLayerUIView = .init()
    view.gradientLayer.colors = [UIColor.red, UIColor.blue].map { $0.cgColor }

    return view
}

#endif

#endif
