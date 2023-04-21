//
//  Collection.EnumeratedArray.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.04.22.
//

import Foundation

// MARK: - Enumerated Array
extension Collection {
    /// Enumerated a `Collection` as a tuple of offset and element.
    ///
    /// Element can be used as id in `ForEach` without use of an explicit identifier.
    ///
    ///     var body: some View {
    ///         ForEach(
    ///             data.enumeratedArray(),
    ///             id: \.element,
    ///             content: { (i, element) in rowContent(element) }
    ///         )
    ///     }
    ///
    public func enumeratedArray() -> Array<(offset: Int, element: Element)> {
        .init(enumerated())
    }
}
