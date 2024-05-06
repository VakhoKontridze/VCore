//
//  UIImage.AverageColor.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Image Average Color
extension UIImage {
    /// Returns average `UIColor`.
    ///
    ///     let color: UIColor? = UIImage(named: "Image")?.averageColor
    ///
    public var averageColor: UIColor? {
        guard let ciImage: CIImage = .init(image: self) else { return nil }

        let vector: CIVector = .init(
            x: ciImage.extent.origin.x,
            y: ciImage.extent.origin.y,
            z: ciImage.extent.size.width,
            w: ciImage.extent.size.height
        )
        
        guard
            let filter: CIFilter = .init(
                name: "CIAreaAverage",
                parameters: [
                    kCIInputImageKey: ciImage,
                    kCIInputExtentKey: vector
                ]
            ),
            let outputImage: CIImage = filter.outputImage
        else {
            return nil
        }
        
        var bitmap: [UInt8] = .init(repeating: 0, count: 4)
        
        let context: CIContext = .init(
            options: [
                .workingColorSpace: kCFNull as Any
            ]
        )
        context.render(
            outputImage,
            toBitmap: &bitmap,
            rowBytes: 4,
            bounds: CGRect(
                origin: CGPoint.zero,
                size: CGSize(dimension: 1)
            ),
            format: .RGBA8,
            colorSpace: nil
        )

        let red: CGFloat = .init(bitmap[0]) / 255
        let green: CGFloat = .init(bitmap[1]) / 255
        let blue: CGFloat = .init(bitmap[2]) / 255
        let alpha: CGFloat = .init(bitmap[3]) / 255

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

// MARK: - Preview
#if DEBUG

import SwiftUI

#Preview(body: {
    guard
        let image: UIImage = .init(
            size: CGSize(dimension: 100),
            color: UIColor.blend(.red, with: .blue)
        ),
        let averageColor: UIColor = image.averageColor
    else {
        return EmptyView()
    }

    return Color(uiColor: averageColor)
})

#endif

#endif
