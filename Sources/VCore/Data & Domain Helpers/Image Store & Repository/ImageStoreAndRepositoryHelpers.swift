//
//  ImageStoreAndRepositoryHelpers.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

import SwiftUI

nonisolated extension CGSize {
    func quantized() -> Self {
        guard
            width > 0,
            height > 0
        else {
            return self
        }
        
        if width >= height {
            let snappedWidth: CGFloat = width.quantized()
            
            let scale: CGFloat = snappedWidth / width
            
            return CGSize(
                width: snappedWidth,
                height: (height * scale).rounded()
            )
            
        } else {
            let snappedHeight: CGFloat = height.quantized()
            
            let scale: CGFloat = snappedHeight / height
            
            return CGSize(
                width: (width * scale).rounded(),
                height: snappedHeight
            )
        }
    }
}

nonisolated extension CGFloat {
    fileprivate func quantized() -> CGFloat {
        let step: CGFloat = {
            if self < 100 {
                8
            } else if self < 500 {
                16
            } else {
                32
            }
        }()
        
        return (self / step).rounded() * step
    }
}

nonisolated extension PlatformImage {
    var cacheCost: Int {
        Int(
            size.width * scale *
            size.height * scale *
            4
        )
    }
}
