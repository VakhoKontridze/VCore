//
//  OptionSet.Elements.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.22.
//

import Foundation

// MARK: - Option Set Elements
extension OptionSet where RawValue: FixedWidthInteger {
    /// Returns all elements in `OptionSet`.
    ///
    ///     struct RGBColor: OptionSet {
    ///         static let red: Self = .init(rawValue: 1 << 0)
    ///         static let green: Self = .init(rawValue: 1 << 1)
    ///         static let blue: Self = .init(rawValue: 1 << 2)
    ///
    ///         static var all: Self { [.red, .green, .blue] }
    ///
    ///         let rawValue: Int
    ///     }
    ///
    ///     let colors: [RGBColor] = RGBColor.all.elements // [.red, .green, .blue]
    ///
    public var elements: [Self] {
        var remainingBits: RawValue = rawValue
        var bitMask: RawValue = 1
        
        let elements: AnySequence<Self> = .init({
            AnyIterator({
                while remainingBits != 0 {
                    defer { bitMask = bitMask &* 2 }
                    
                    if remainingBits & bitMask != 0 {
                        remainingBits = remainingBits & ~bitMask
                        return Self(rawValue: bitMask)
                    }
                }
                
                return nil
            })
        })
        
        return Array(elements)
    }
}
