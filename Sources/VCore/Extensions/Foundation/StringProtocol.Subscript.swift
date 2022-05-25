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
    ///
    ///     let string: String = "Lorem Ipsum"
    ///     let firstChar: Character = string[0] // "L"
    ///
    public subscript(_ i: Int) -> Element {
        assert(i >= 0 && i < count, "Index Out of Range")
        return self[index(startIndex, offsetBy: i)]
    }
}

// MARK: - Set
extension StringProtocol {
    /// Returns string with an element replaced at index.
    ///
    ///     let string: String = "Lorem ipsum"
    ///     let replacedString: String = string.replaced(at: 0, with: "l") // "lorem ipsum"
    ///
    public func replaced(at i: Int, with element: Element) -> Self {
        assert(i >= 0 && i < count, "Index Out of Range")
        return "\(prefix(i))\(element)\(dropFirst(i+1))"
    }
    
    /// Replaces an element at index.
    ///
    ///     var string: String = "Lorem ipsum"
    ///     string.replacing(at: 0, with: "l") // "lorem ipsum"
    ///
    mutating public func replacing(at i: Int, with element: Element) {
        self = replaced(at: i, with: element)
    }
}
