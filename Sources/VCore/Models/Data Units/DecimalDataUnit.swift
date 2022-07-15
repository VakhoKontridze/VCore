//
//  DecimalDataUnit.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.07.22.
//

import Foundation

// MARK: - Decimal Data Unit
/// Decimal data unit with a metric base of  `1000`.
///
/// `rawValue` defines the `magnitude`.
///
/// Only defines officially recognized units.
public enum DecimalDataUnit: Int, DataUnit, Hashable, Equatable, Identifiable, CaseIterable {
    // MARK: Cases
    /// Byte (1000^0).
    case B = 0
    
    /// Kilobyte (1000^1).
    case kB = 1 // Lowercase "k"
    
    /// Megabyte (1000^2).
    case MB = 2
    
    /// Gigabyte (1000^3).
    case GB = 3
    
    /// Terabyte (1000^4).
    case TB = 4
    
    /// Petabyte (1000^5).
    case PB = 5
    
    /// Exabyte (1000^6).
    case EB = 6
    
    /// Zettabyte (1000^7).
    case ZB = 7
    
    /// Yottabyte (1000^8).
    case YB = 8
    
    // MARK: Data Unit
    public static var base: Int { 1000 }
    
    // MARK: Identifiable
    public var id: Int { rawValue }
}

// MARK: - Bytes to Decimal Data Unit
extension Double {
    /// Converts bytes to decimal data unit.
    ///
    ///     1000.convertDecimalBytes(to: .kB) // 1
    ///
    public func convertDecimalBytes(to dataUnit: DecimalDataUnit) -> Double {
        DecimalDataUnit.convert(self, .B, to: dataUnit)
    }
}
