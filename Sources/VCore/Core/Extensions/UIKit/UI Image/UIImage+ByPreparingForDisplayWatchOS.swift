//
//  UIImage+ByPreparingForDisplayWatchOS.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21/10/26.
//

#if canImport(UIKit)

import UIKit

nonisolated extension UIImage {
    func byPreparingForDisplayWatchOS() -> UIImage? {
        guard
            let cgImage,
            let decodedCGImage: CGImage = cgImage.decoded()
        else {
            return nil
        }

        return UIImage(
            cgImage: decodedCGImage,
            scale: scale,
            orientation: imageOrientation
        )
    }
}

#endif
