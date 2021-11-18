//
//  String.NonEmpty.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/18/21.
//

import Foundation

// MARK: - Non Empty String
extension String {
    /// Indicates whether a string has no characters or whitespaces.
    public var isEmptyOrWhiteSpace: Bool {
        trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    /// Indicates whether a string has no characters, whitespaces, or newlines.
    public var isEmptyWhiteSpaceOrNewLines: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension String {
    /// Returns non-empty version of `String`, or `nil`.
    public var nonEmpty: String? {
        guard !self.isEmpty else { return nil }
        return self
    }
    
    /// Returns non-empty and non-whitespace version of `String`, or `nil`.
    public var nonEmptyOrWhiteSpace: String? {
        guard !self.isEmptyOrWhiteSpace else { return nil }
        return self
    }
    
    /// Returns non-empty, non-whitespace, and non-newline version of `String`, or `nil`.
    public var nonEmptyWhiteSpaceOrNewLines: String? {
        guard !self.isEmptyWhiteSpaceOrNewLines else { return nil }
        return self
    }
}
