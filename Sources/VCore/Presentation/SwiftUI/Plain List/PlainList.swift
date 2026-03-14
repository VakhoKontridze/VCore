//
//  PlainList.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27.11.23.
//

import SwiftUI

/// Container that presents rows of data arranged in a single column.
///
///     PlainList {
///         ForEach(0..<3, id: \.self) { i in
///             Text("Row \(i+1)")
///                 .frame(maxWidth: .infinity, alignment: .leading)
///                 .padding(.horizontal, 15)
///                 .padding(.vertical, 9)
///         }
///     }
///
@available(tvOS, unavailable) // Doesn't follow HIG. Implementation doesn't fully work.
@available(watchOS, unavailable) // Doesn't follow HIG. Implementation doesn't fully work.
public struct PlainList<Content>: View where Content: View {
    // MARK: Properties
    private let appearance: PlainListAppearance
    private let content: () -> Content

    // MARK: Initializers
    /// Initializes `PlainList` with content.
    public init(
        appearance: PlainListAppearance = .init(),
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.appearance = appearance
        self.content = content
    }

    // MARK: Body
    public var body: some View {
        List {
            content()
                .removingListContentDecoration()
                .listRowBackground(appearance.rowBackgroundColor)
        }
        .removingListDecoration()
        .listStyle(.plain)
    }
}

#if DEBUG

#if !(os(tvOS) || os(watchOS)) // Redundant

#Preview {
    PlainList {
        ForEach(0..<3, id: \.self) { i in
            Text("Row \(i+1)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
                .padding(.vertical, 9)
        }
    }
}

#endif

#endif
