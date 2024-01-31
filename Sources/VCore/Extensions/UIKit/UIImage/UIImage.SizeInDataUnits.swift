//
//  UIImage.SizeInDataUnits.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.07.22.
//

#if canImport(UIKit)

import UIKit

// MARK: - Image Size in Decimal Data Units
extension UIImage {
    /// Returns `UIImage` size in kilobytes.
    ///
    ///     let sizeInKilobytes: Double? = image.sizeInKilobytes
    ///
    public var sizeInKilobytes: Double? {
        (pngData()?.count).map { Double($0) }?.decimalBytesConverted(to: .kB)
    }
    
    /// Returns `UIImage` size in megabytes.
    ///
    ///     let sizeInMegabytes: Double? = image.sizeInMegabytes
    ///
    public var sizeInMegabytes: Double? {
        (pngData()?.count).map { Double($0) }?.decimalBytesConverted(to: .MB)
    }
}

// MARK: - Image Size in Binary Data Units
extension UIImage {
    /// Returns `UIImage` size in kibibytes.
    ///
    ///     let sizeInKibibytes: Double? = image.sizeInKibibytes
    ///
    public var sizeInKibibytes: Double? {
        (pngData()?.count).map { Double($0) }?.binaryBytesConverted(to: .KiB)
    }
    
    /// Returns `UIImage` size in mebibytes.
    ///
    ///     let sizeInMebibytes: Double? = image.sizeInMebibytes
    ///
    public var sizeInMebibytes: Double? {
        (pngData()?.count).map { Double($0) }?.binaryBytesConverted(to: .MiB)
    }
}

#endif
