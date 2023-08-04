//
//  String.UnwrappedDescribing.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/18/21.
//

import Foundation

// MARK: - String Unwrapped Describing
extension String {
    /// Creates a `String` representing the given value, or returns `nil`.
    ///
    ///     let a: Int? = 5
    ///     String(describing: a)           // "Optional(5)"
    ///     String(unwrappedDescribing: a)! // "5"
    ///
    ///     let b: Int? = nil
    ///     String(describing: b)           // nil
    ///     String(unwrappedDescribing: b)  // nil
    ///
    public init?<Subject>(unwrappedDescribing instance: Subject?) {
        guard let instance else { return nil }
        self.init(describing: instance)
    }
}
