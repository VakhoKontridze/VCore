//
//  UIImage.Rotated.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/8/21.
//

#if canImport(UIKit)

import UIKit

// MARK: - UI Image Rotated
extension UIImage {
    /// Returns `UIImage` rotated by angle.
    ///
    ///     let image: UIImage = .init(named: "Image")!
    ///     let rotatedImage: UIImage? = image.rotated(by: Measurement(value: 90, unit: .degrees))
    ///
    public func rotated(by angle: Measurement<UnitAngle>) -> UIImage? {
        let radians: CGFloat = .init(angle.converted(to: .radians).value)
        
        let newRect: CGRect = {
            var newRect: CGRect = .init(origin: .zero, size: size)
                .applying(CGAffineTransform(rotationAngle: radians))
            
            newRect = CGRect(
                x: newRect.origin.x,
                y: newRect.origin.y,
                width: newRect.width,
                height: newRect.height
            )
            
            return newRect
        }()
        
        UIGraphicsBeginImageContextWithOptions(newRect.size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        guard let cgContext: CGContext = UIGraphicsGetCurrentContext() else { return nil }
        
        cgContext.translateBy(x: newRect.width/2, y: newRect.height/2)
        cgContext.rotate(by: radians)
        
        draw(
            in: CGRect(
                origin: .init(
                    x: -size.width / 2,
                    y: -size.height / 2
                ),
                size: size
            )
        )

        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// Rotates `UIImage` by radian.
    ///
    ///     let image: UIImage = .init(named: "Image")!
    ///     let rotatedImage: UIImage? = image.rotated(byRadians: .pi / 2)
    ///
    public func rotated(byRadians radians: CGFloat) -> UIImage? {
        rotated(by: Measurement(value: radians, unit: .radians))
    }
    
    /// Rotates `UIImage` by degrees.
    ///
    ///     let image: UIImage = .init(named: "Image")!
    ///     let rotatedImage: UIImage? = image.rotated(byDegrees: 90)
    ///
    public func rotated(byDegrees degrees: CGFloat) -> UIImage? {
        rotated(by: Measurement(value: degrees, unit: .degrees))
    }
}

#endif
