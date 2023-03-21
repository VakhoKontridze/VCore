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
    ///     struct SomeOptionSet: OptionSet {
    ///         static let first: Self = .init(rawValue: 1 << 0)
    ///         static let second: Self = .init(rawValue: 1 << 1)
    ///         static let third: Self = .init(rawValue: 1 << 2)
    ///
    ///         static var all: Self { [.first, .second, .third] }
    ///
    ///         let rawValue: Int
    ///     }
    ///
    ///     let options: [SomeOptionSet] = SomeOptionSet.all.elements // [.first, .second, .third]
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
        
        return .init(elements)
    }
}
