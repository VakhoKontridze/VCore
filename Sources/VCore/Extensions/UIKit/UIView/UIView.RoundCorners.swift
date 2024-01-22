//
//  UIView.RoundCorners.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Round View Corners
extension UIView {
    /// Rounds corners.
    ///
    /// Sets `clipsToBounds` to `true`.
    ///
    ///     view.roundCorners(.layerAllCorners, by: 10)
    ///
    public func roundCorners(
        _ corners: CACornerMask,
        by radius: CGFloat,
        curve: CALayerCornerCurve = .circular
    ) {
        clipsToBounds = true
        layer.maskedCorners = corners
        layer.cornerRadius = radius
        layer.cornerCurve = curve
    }
}

// MARK: - Preview
#if DEBUG

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview(body: {
    let view: UIView = .init()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.systemBlue
    view.roundCorners(.layerAllCorners, by: 10)

    NSLayoutConstraint.activate([
        view.constraintWidth(to: nil, constant: 100),
        view.constraintHeight(to: nil, constant: 100)
    ])

    return view
})

#endif

#endif
