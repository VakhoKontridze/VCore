//
//  PlainList.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27.11.23.
//

import SwiftUI

// MARK: - Plain List
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
    private let uiModel: PlainListUIModel
    private let content: () -> Content

    // MARK: Initializers
    /// Initializes `PlainList` with content.
    public init(
        uiModel: PlainListUIModel = .init(),
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.uiModel = uiModel
        self.content = content
    }

    // MARK: Body
    public var body: some View {
        List {
            content()
                .removingListContentDecoration()
                .listRowBackground(uiModel.rowBackgroundColor)
        }
        .removingListDecoration()
        .listStyle(.plain)
    }
}

// MARK: - Preview
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
