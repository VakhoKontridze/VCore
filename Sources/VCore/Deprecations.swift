//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import Foundation

// MARK: - Multi Part Form Data Builder
@available(*, deprecated, renamed: "AnyMultiPartFormDataFile")
public typealias AnyMultiPartFormFile = AnyMultiPartFormDataFile

// MARK: - JSON Type Casts
extension Optional where Wrapped == Any {
    @available(*, deprecated, renamed: "toUnwrappedJSON")
    public var toWrappedJSON: [String: Any?] {
        return toUnwrappedJSON
    }

    @available(*, deprecated, renamed: "toUnwrappedJSONArray")
    public var toWrappedJSONArray: [[String: Any?]] {
        toUnwrappedJSONArray
    }
}
