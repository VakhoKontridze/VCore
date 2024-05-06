//
//  UIView.ApplyShadow.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/9/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI View Apply Shadow
extension UIView {
    /// Applies shadow to `UIView`.
    ///
    ///     view.applyShadow(
    ///         color: UIColor.black.withAlphaComponent(0.16),
    ///         radius: 5,
    ///         offset: CGSize(width: 0, height: 5)
    ///     )
    ///
    public func applyShadow(
        color: UIColor?,
        radius: CGFloat,
        offset: CGSize
    ) {
        layer.shadowColor = color?.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }
    
    /// Rounds corners and applies shadow to `UIView`.
    ///
    ///     view.roundCornersAndApplyShadow(
    ///         cornerRadius: 10,
    ///         color: UIColor.black.withAlphaComponent(0.16),
    ///         radius: 5,
    ///         offset: CGSize(width: 0, height: 5)
    ///     )
    ///
    public func roundCornersAndApplyShadow(
        cornerRadius: CGFloat,
        curve: CALayerCornerCurve = .circular,
        color: UIColor?,
        radius: CGFloat,
        offset: CGSize
    ) {
        layer.cornerRadius = cornerRadius
        layer.cornerCurve = curve
        applyShadow(
            color: color,
            radius: radius,
            offset: offset
        )
    }
}

// MARK: - Preview
#if DEBUG

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview(body: {
    let view: UIView = .init()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.systemBlue
    view.applyShadow(
        color: UIColor.black.withAlphaComponent(0.3),
        radius: 5,
        offset: CGSize(dimension: 5)
    )

    NSLayoutConstraint.activate([
        view.constraintWidth(to: nil, constant: 100),
        view.constraintHeight(to: nil, constant: 100)
    ])

    return view
})

#endif

#endif
