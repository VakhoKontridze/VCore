//
//  PlainListDecoration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27.11.23.
//

import SwiftUI

// MARK: - Plain List Decoration
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension View {
    /// Removes `List` decoration for `PlainList`.
    public func removingListDecoration() -> some View {
        self
            .environment(\.defaultMinListRowHeight, 0)
    }

    /// Removes `List` content decoration for `PlainList`.
    public func removingListContentDecoration() -> some View {
        self
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
    }
}
