//
//  String.SafelyDescribing.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/18/21.
//

import Foundation

// MARK: - Safely Describing String
extension String {
    /// Sreates a `String` representing the given value, or returns `nil`.
    ///
    /// Usage Example
    ///
    ///     let a: Int? = 5
    ///     print(String(describing: a))        // "Optional(5)"
    ///     print(String(safelyDescribing: a)!) // "5"
    ///
    ///     let b: Int? = nil
    ///     print(String(describing: b))        // nil
    ///     print(String(safelyDescribing: b))  // nil
    ///
    public init?<Subject>(safelyDescribing instance: Subject?) {
        guard let instance = instance else { return nil }
        self.init(describing: instance)
    }
}
