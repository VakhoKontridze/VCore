//
//  Collection+EnumeratedArray.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.04.22.
//

import Foundation

nonisolated extension Collection { // TODO: iOS 26.0 - Remove
    /// Enumerated a `Collection` as a tuple of offset and element.
    ///
    /// Element can be used as id in `ForEach` without use of an explicit identifier.
    ///
    ///     var body: some View {
    ///         ForEach(data.enumeratedArray(), id: \.element) { (i, element) in
    ///             ...
    ///         }
    ///     }
    ///
    @available(iOS, deprecated: 26.0, message: "Use native 'enumerated(...)' method instead")
    @available(macOS, deprecated: 26.0, message: "Use native 'enumerated(...)' method instead")
    @available(tvOS, deprecated: 26.0, message: "Use native 'enumerated(...)' method instead")
    @available(watchOS, deprecated: 26.0, message: "Use native 'enumerated(...)' method instead")
    @available(visionOS, deprecated, message: "Use native 'enumerated(...)' method instead")
    public func enumeratedArray() -> [(offset: Int, element: Element)] {
        .init(enumerated())
    }
}
