//
//  CaseIterable+Cases.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.05.23.
//

import Foundation

// MARK: - Case Iterable + Cases
extension CaseIterable where Self: Hashable {
    /// Returns a `case` with specified distance from the current `case`.
    ///
    ///     enum CardinalDirection: CaseIterable {
    ///         case north
    ///         case east
    ///         case south
    ///         case west
    ///     }
    ///
    ///     let current: CardinalDirection = .east
    ///     let next: CardinalDirection? = current.aCase(offsetBy: 1) // south
    ///
    public func aCase(offsetBy distance: Int) -> Self? {
        guard
            let currentIndex: AllCases.Index = Self.allCases.firstIndex(of: self)
        else {
            return nil
        }

        let targetIndex: AllCases.Index = Self.allCases.index(currentIndex, offsetBy: distance)

        guard
            let targetCase: Self = Self.allCases[safe: targetIndex]
        else {
            return nil
        }

        return targetCase
    }

    /// Returns previous `case`.
    ///
    ///     enum CardinalDirection: CaseIterable {
    ///         case north
    ///         case east
    ///         case south
    ///         case west
    ///     }
    ///
    ///     let current: CardinalDirection = .east
    ///     let previous: CardinalDirection? = current.previousCase // north
    ///
    public var previousCase: Self? {
        aCase(offsetBy: -1)
    }

    /// Returns next `case`.
    ///
    ///     enum CardinalDirection: CaseIterable {
    ///         case north
    ///         case east
    ///         case south
    ///         case west
    ///     }
    ///
    ///     let current: CardinalDirection = .east
    ///     let next: CardinalDirection? = current.nextCase // south
    ///
    public var nextCase: Self? {
        aCase(offsetBy: 1)
    }
}
