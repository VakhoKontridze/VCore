//
//  StringProtocol.Subscript.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import Foundation

// MARK: - String Protocol Subscript
extension StringProtocol {
    /// Accesses the element at the specified position.
    ///
    ///     let string: String = "Lorem Ipsum"
    ///     let firstChar: Character = string[0] // "L"
    ///
    public subscript(_ i: Int) -> Element {
        get {
            self[index(startIndex, offsetBy: i)]
        } 
        set {
            replace(at: i, with: newValue)
        }
    }
}
