//
//  DataUnit.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.07.22.
//

import Foundation

// MARK: - Data Unit
/// Unit of digital information.
public protocol DataUnit {
    /// Unit base.
    ///
    /// For instance, in decimal byte units, `1000`, in binary byte units, `1024`.
    static var base: Int { get }
    
    /// Magnitude of `base` in data unit.
    ///
    /// Has a default implementation is `Int` `RawRepresentable` `enum`s, which returns `rawValue`.
    var magnitude: Int { get }
    
    /// Number of bytes in data unit.
    ///
    /// Has a default implementation of `base` to the power of `magnitude`.
    var bytes: Double { get }
    
    /// Converts size in given data unit to a different type of data unit.
    ///
    /// This method can be used for conversion between `DecimalDataUnit` and `BinaryDataUnit`.
    ///
    /// Has a default implementation.
    ///
    ///     DecimalDataUnit.convert(1, .GB, to: BinaryDataUnit.MiB) // 953.674...
    ///
    static func convert<T>(
        _ size: Double, _ unit: Self,
        to newUnit: T
    ) -> Double
        where T: DataUnit
    
    /// Converts size in given data unit to data unit of the same type.
    ///
    /// Has a default implementation.
    ///
    ///     DecimalDataUnit.convert(1, .GB, to: .MB) // 1000
    ///
    static func convert(
        _ size: Double, _ unit: Self,
        to newUnit: Self
    ) -> Double
}

extension DataUnit {
    public var bytes: Double {
        pow(Double(Self.base), Double(magnitude))
    }
    
    public static func convert<T>(
        _ size: Double, _ unit: Self,
        to newUnit: T
    ) -> Double
        where T: DataUnit
    {
        let bytes1: Double = pow(Double(Self.base), Double(unit.magnitude))
        let bytes2: Double = pow(Double(T.base), Double(newUnit.magnitude))
        
        return size * (bytes1 / bytes2)
    }
    
    public static func convert(
        _ size: Double, _ unit: Self,
        to newUnit: Self
    ) -> Double {
        let base: Double = .init(Self.base)
        let magnitude: Double = Double(unit.magnitude) - Double(newUnit.magnitude)
        
        return size * pow(base, magnitude)
    }
}

extension DataUnit where Self: RawRepresentable, RawValue == Int {
    public var magnitude: Int { rawValue }
}
