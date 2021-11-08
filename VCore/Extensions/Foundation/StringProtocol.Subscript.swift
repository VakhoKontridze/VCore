//
//  StringProtocol.Subscript.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import Foundation

// MARK: - Get
extension StringProtocol {
    /// Accesses the element at the specified position.
    public subscript(_ i: Int) -> Element {
        assert(i >= 0 && i < count, "Index Out of Range")
        return self[index(startIndex, offsetBy: i)]
    }
}

// MARK: - Set
extension StringProtocol {
    /// Returns string with an element replaced at index.
    public func replaced(at i: Int, with element: Element) -> Self {
        assert(i >= 0 && i < count, "Index Out of Range")
        return "\(prefix(i))\(element)\(dropFirst(i+1))"
    }
    
    /// Replaces an element at index.
    public mutating func replacing(at i: Int, with element: Element) {
        self = replaced(at: i, with: element)
    }
}
