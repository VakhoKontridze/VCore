//
//  ModuleVersion.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation

// MARK: - Module Version
/// Version according to the semantic versioning specification.
///
/// When initializing with `String`, valid formats are: `M`, `M.M`, and `M.M.P`.
///
///     ModuleVersion(string: Bundle.main.version)?.description // 1.0
///
public struct ModuleVersion: Equatable, Hashable, Comparable, Identifiable, Sendable, CustomStringConvertible {
    // MARK: Properties
    /// Major version according to the semantic versioning standard.
    public var major: Int
    
    /// Minor version according to the semantic versioning standard.
    public var minor: Int
    
    /// Patch version according to the semantic versioning standard.
    public var patch: Int?
    
    /// Unwrapped patch version according to the semantic versioning standard.
    ///
    /// Contains `patch` or `0`.
    public var patchUnwrapped: Int { patch ?? 0 }
    
    private static var allowedCharacters: CharacterSet {
        .decimalDigits
        .union(CharacterSet(charactersIn: "."))
    }
    
    // MARK: Initializers
    /// Initializes `ModuleVersion` with versions.
    public init(
        _ major: Int,
        _ minor: Int,
        _ patch: Int? = nil
    ) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }
    
    /// Initializes `ModuleVersion` with `String`.
    public init?(string: String?) {
        guard
            let string,
            string.contains(only: Self.allowedCharacters)
        else {
            return nil
        }
        
        let components: [Int] = string.components(separatedBy: ".").compactMap { Int($0) }
        guard (1...3).contains(components.count) else { return nil }
        
        if let major: Int = components[safe: 0] {
            if let minor: Int = components[safe: 1] {
                if let patch: Int = components[safe: 2] {
                    self.init(major, minor, patch)
                } else {
                    self.init(major, minor, nil)
                }
            } else {
                self.init(major, 0, nil)
            }
        } else {
            return nil
        }
    }
    
    // MARK: Description
    /// Textual representation.
    public func description(showsEmptyPatchVersionAsZero: Bool = false) -> String {
        if showsEmptyPatchVersionAsZero {
            "\(major).\(minor).\(patchUnwrapped)"
        } else if let patch = patch {
            "\(major).\(minor).\(patch)"
        } else {
            "\(major).\(minor)"
        }
    }

    // MARK: Equatable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        isEqual(lhs, to: rhs, by: \.major, \.minor, \.patchUnwrapped)
    }
    
    // MARK: Identifiable
    public var id: String { description }
    
    // MARK: Comparable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        isLess(lhs, than: rhs, by: \.major, \.minor, \.patchUnwrapped)
    }

    // MARK: Custom String Convertible
    public var description: String {
        description()
    }
}
