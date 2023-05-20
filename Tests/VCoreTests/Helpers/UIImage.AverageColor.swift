//
//  UIImage.AverageColor.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Image Average Color
extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage: CIImage = .init(image: self) else { return nil }
        
        let extentVector: CIVector = .init(
            x: inputImage.extent.origin.x,
            y: inputImage.extent.origin.y,
            z: inputImage.extent.size.width,
            w: inputImage.extent.size.height
        )
        
        guard
            let filter: CIFilter = .init(
                name: "CIAreaAverage",
                parameters: [
                    kCIInputImageKey: inputImage,
                    kCIInputExtentKey: extentVector
                ]
            ),
            let outputImage: CIImage = filter.outputImage
        else {
            return nil
        }
        
        var bitmap: [UInt8] = .init(repeating: 0, count: 4)
        let context: CIContext = .init(options: [.workingColorSpace: kCFNull as Any])
        context.render(
            outputImage,
            toBitmap: &bitmap,
            rowBytes: 4,
            bounds: CGRect(origin: .zero, size: CGSize(dimension: 1)),
            format: .RGBA8,
            colorSpace: nil
        )

        let red: CGFloat = CGFloat(bitmap[0]) / 255
        let green: CGFloat = CGFloat(bitmap[1]) / 255
        let blue: CGFloat = CGFloat(bitmap[2]) / 255
        let alpha: CGFloat = CGFloat(bitmap[3]) / 255

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

#endif
