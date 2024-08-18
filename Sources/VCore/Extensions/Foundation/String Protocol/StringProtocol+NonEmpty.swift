//
//  StringProtocol+NonEmpty.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/18/21.
//

import Foundation

// MARK: - String Protocol + Non-Empty
extension StringProtocol {
    /// Indicates whether a `String` has no `Character`s or whitespaces.
    ///
    ///     let value1: Bool = "".isEmptyOrWhiteSpace // true
    ///     let value2: Bool = " ".isEmptyOrWhiteSpace // true
    ///     let value3: Bool = "Lorem Ipsum".isEmptyOrWhiteSpace // false
    ///
    public var isEmptyOrWhiteSpace: Bool {
        trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    /// Indicates whether a `String` has no `Character`s, whitespaces, or newlines.
    ///
    ///     let value1: Bool = "".isEmptyWhiteSpaceOrNewLines // true
    ///     let value2: Bool = " ".isEmptyWhiteSpaceOrNewLines // true
    ///     let value3: Bool = "\n".isEmptyWhiteSpaceOrNewLines // true
    ///     let value4: Bool = "Lorem Ipsum".isEmptyWhiteSpaceOrNewLines // false
    ///
    public var isEmptyWhiteSpaceOrNewLines: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension StringProtocol {
    /// Returns non-empty `String`, or `nil`.
    ///
    ///     let value1: String? = "".nonEmpty // nil
    ///     let value2: String? = "Lorem Ipsum".nonEmpty // "Lorem Ipsum"
    ///     
    public var nonEmpty: Self? {
        guard !isEmpty else { return nil }
        return self
    }
    
    /// Returns non-empty and non-whitespace `String`, or `nil`.
    ///
    ///     let value1: String? = "".nonEmptyOrWhiteSpace // nil
    ///     let value2: String? = " ".nonEmptyOrWhiteSpace // nil
    ///     let value3: String? = "Lorem Ipsum".nonEmptyOrWhiteSpace // "Lorem Ipsum"
    ///
    public var nonEmptyOrWhiteSpace: Self? {
        guard !isEmptyOrWhiteSpace else { return nil }
        return self
    }
    
    /// Returns non-empty, non-whitespace, and non-newline `String`, or `nil`.
    ///
    ///     let value1: String? = "".nonEmptyWhiteSpaceOrNewLines // nil
    ///     let value2: String? = " ".nonEmptyWhiteSpaceOrNewLines // nil
    ///     let value3: String? = "\n".nonEmptyWhiteSpaceOrNewLines // nil
    ///     let value4: String? = "Lorem Ipsum".nonEmptyWhiteSpaceOrNewLines // "Lorem Ipsum"
    ///
    public var nonEmptyWhiteSpaceOrNewLines: Self? {
        guard !isEmptyWhiteSpaceOrNewLines else { return nil }
        return self
    }
}
