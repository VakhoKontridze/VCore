//
//  PlainListDecoration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27.11.23.
//

import SwiftUI

// MARK: - List Decoration
extension View {
    /// Removes `List` decoration for `PlainList`.
    public func removingListDecoration() -> some View {
        self
            .environment(\.defaultMinListRowHeight, 0)
    }

    /// Removes `List` content decoration for `PlainList`.
    public func removingListContentDecoration() -> some View {
        self
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
    }
}
