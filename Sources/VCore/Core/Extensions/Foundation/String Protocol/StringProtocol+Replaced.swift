//
//  StringProtocol+Replaced.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11.12.23.
//

import Foundation

nonisolated extension StringProtocol {
    /// Returns `String` with an element replaced at index.
    ///
    ///     let string: String = "Lorem ipsum"
    ///     let replacedString: String = string.replaced(at: 0, with: "l") // "lorem ipsum"
    ///
    public func replaced(at i: Int, with element: Element) -> Self {
        guard i >= 0, i < count else { return self }
        return "\(prefix(i))\(element)\(dropFirst(i+1))"
    }

    /// Replaces an element at index.
    ///
    ///     var string: String = "Lorem ipsum"
    ///     string.replace(at: 0, with: "l") // "lorem ipsum"
    ///
    mutating public func replace(at i: Int, with element: Element) {
        self = replaced(at: i, with: element)
    }
}
