//
//  Data.NonEmpty.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import Foundation

// MARK: - Data Non Empty
extension Data {
    /// Returns non-zero sized `Data`, or `nil`.
    ///
    ///     let data1: Data? = .init().nonEmpty // nil
    ///     let data2: Data? = .init("data".data(using: .utf8)!).nonEmpty // ...
    ///
    public var nonEmpty: Data? {
        guard count != 0 else { return nil }
        return self
    }
}
