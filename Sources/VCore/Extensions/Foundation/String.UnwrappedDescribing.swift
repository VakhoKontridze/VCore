//
//  String.UnwrappedDescribing.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/18/21.
//

import Foundation

// MARK: - Unwrapped Describing String
extension String {
    /// Creates a `String` representing the given value, or returns `nil`.
    ///
    ///     let a: Int? = 5
    ///     print(String(describing: a))            // "Optional(5)"
    ///     print(String(unwrappedDescribing: a)!)  // "5"
    ///
    ///     let b: Int? = nil
    ///     print(String(describing: b))            // nil
    ///     print(String(unwrappedDescribing: b))   // nil
    ///
    public init?<Subject>(unwrappedDescribing instance: Subject?) {
        guard let instance else { return nil }
        self.init(describing: instance)
    }
}
