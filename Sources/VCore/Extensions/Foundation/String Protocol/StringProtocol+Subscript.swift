//
//  StringProtocol+Subscript.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import Foundation
import OSLog

extension StringProtocol {
    /// Accesses the element at the specified position.
    ///
    ///     let string: String = "Lorem Ipsum"
    ///     let firstChar: Character = string[0] // "L"
    ///
    public subscript(_ i: Int) -> Element {
        get {
            guard i >= 0 && i < count else {
                Logger.misc.critical("Index \(i) out of bounds")
                fatalError() // Unsafe
            }
            
            return self[index(startIndex, offsetBy: i)]
        }
        set {
            guard i >= 0 && i < count else {
                Logger.misc.critical("Index \(i) out of bounds")
                fatalError() // Unsafe
            }
            
            replace(at: i, with: newValue)
        }
    }
}
