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
///     PlainList(content: {
///         ForEach(0..<3, id: \.self, content: { i in
///             Text("Row \(i+1)")
///                 .frame(maxWidth: .infinity, alignment: .leading)
///                 .padding(.horizontal, 15)
///                 .padding(.vertical, 9)
///         })
///     })
///
@available(macOS 13.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
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
        List(content: {
            content()
                .removingListContentDecoration()
                .listRowBackground(uiModel.rowBackgroundColor)
        })
        .removingListDecoration()
        .listStyle(.plain)
    }
}

// MARK: - Preview
@available(macOS 13.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
struct PlainList_Previews: PreviewProvider {
    static var previews: some View {
        PlainList(content: {
            ForEach(0..<3, id: \.self, content: { i in
                Text("Row \(i+1)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 9)
            })
        })
    }
}
