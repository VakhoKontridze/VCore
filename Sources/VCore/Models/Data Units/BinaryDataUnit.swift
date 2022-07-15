//
//  BinaryDataUnit.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.07.22.
//

import Foundation

// MARK: - Binary Data Unit
/// Binary data unit with a ISO/IEC `80000` base of  `1024`.
///
/// `rawValue` defines the `magnitude`.
///
/// Only defines officially recognized units.
public enum BinaryDataUnit: Int, DataUnit, CaseIterable, Hashable, Equatable, Identifiable {
    // MARK: Cases
    /// Byte (1024^0 or 2^0).
    case B = 0
    
    /// Kibibyte (1024^1 or 2^10).
    case KiB = 1
    
    /// Mebibyte (1024^2 or 2^20).
    case MiB = 2
    
    /// Gibibyte (1024^3 or 2^30).
    case GiB = 3
    
    /// Tebibyte (1024^4 or 2^40).
    case TiB = 4
    
    /// Pebibyte (1024^5 or 2^50).
    case PiB = 5
    
    /// Exbibyte (1024^6 or 2^60).
    case EiB = 6
    
    /// Zebibyte (1024^7 or 2^70).
    case ZiB = 7
    
    /// Yobibyte (1024^8 or 2^80).
    case YiB = 8
    
    // MARK: Data Unit
    public static var base: Int { 1024 }
    
    // MARK: Identifiable
    public var id: Int { rawValue }
}

// MARK: - Bytes to Binary Data Unit
extension Double {
    /// Converts bytes to binary data unit.
    ///
    ///     1024.convertDecimalBytes(to: .kB) // 1
    ///
    public func convertBinaryBytes(to dataUnit: BinaryDataUnit) -> Double {
        BinaryDataUnit.convert(self, .B, to: dataUnit)
    }
}
