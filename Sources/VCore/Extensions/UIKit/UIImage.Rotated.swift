//
//  UIImage.Rotated.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

#if canImport(UIKit)

import UIKit

// MARK: - Image Rotation
extension UIImage {
    /// Rotates `UIImage` by angle.
    ///
    /// Usage Example:
    ///
    ///     let image: UIImage = .init(named: "SomeImage")!
    ///     let rotatedImage: UIImage? = image.rotated(by: .init(value: 90, unit: .degrees))
    ///
    public func rotated(by angle: Measurement<UnitAngle>) -> UIImage? {
        let radians: CGFloat = .init(angle.converted(to: .radians).value)
        
        var newRect: CGRect = .init(origin: .zero, size: size).applying(.init(rotationAngle: radians))
        newRect = .init(
            x: newRect.origin.x.rounded(),
            y: newRect.origin.y.rounded(),
            width: newRect.width.rounded(),
            height: newRect.height.rounded()
        )
        
        UIGraphicsBeginImageContextWithOptions(newRect.size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        guard let cgContext: CGContext = UIGraphicsGetCurrentContext() else { return nil }
        
        cgContext.translateBy(x: newRect.width/2, y: newRect.height/2)
        cgContext.rotate(by: radians)
        
        draw(in: .init(
            origin: .init(
                x: -size.width / 2,
                y: -size.height / 2
            ),
            size: size
        ))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// Rotates `UIImage` by radian.
    ///
    /// Usage Example:
    ///
    ///     let image: UIImage = .init(named: "SomeImage")!
    ///     let rotatedImage: UIImage? = image.rotated(byRadians: .pi / 2)
    ///
    public func rotated(byRadians radians: CGFloat) -> UIImage? {
        rotated(by: Measurement(value: radians, unit: .radians))
    }
    
    /// Rotates `UIImage` by degrees.
    ///
    /// Usage Example:
    ///
    ///     let image: UIImage = .init(named: "SomeImage")!
    ///     let rotatedImage: UIImage? = image.rotated(byDegrees: 90)
    ///
    public func rotated(byDegrees degrees: CGFloat) -> UIImage? {
        rotated(by: Measurement(value: degrees, unit: .degrees))
    }
}

#endif
