//
//  DividedForEach.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.06.22.
//

import SwiftUI

// MARK: - Divided ForEach
/// A structure that computes views on demand from an underlying collection of identified data, and inserts separator.
///
///     var body: some View {
///         VStack(content: {
///             DividedForEach(
///                 data: Array(0..<20),
///                 id: \.self,
///                 content: { Text(String($0)).frame(maxWidth: .infinity, alignment: .leading) },
///                 separator: Divider.init
///             )
///         })
///             .padding()
///     }
///
public struct DividedForEach<Data, ID, Content, Separator>: View
    where
        Data: RandomAccessCollection,
        Data.Element: Hashable,
        ID: Hashable,
        Content: View,
        Separator: View
{
    // MARK: Properties
    private let uiModel: DividedForEachUIModel
    
    private let data: Data
    private let id: KeyPath<Data.Element, ID>
    private let content: (Data.Element) -> Content
    
    private let separator: () -> Separator

    // MARK: Initializers
    /// Initializes `DividedForEach` with data, id, and row content.
    public init(
        uiModel: DividedForEachUIModel = .init(),
        data: Data,
        id: KeyPath<Data.Element, ID>,
        content: @escaping (Data.Element) -> Content,
        separator: @escaping () -> Separator
    ) {
        self.uiModel = uiModel
        self.data = data
        self.id = id
        self.content = content
        self.separator = separator
    }
    
    /// Initializes `DividedForEach` with data and row content.
    public init(
        uiModel: DividedForEachUIModel = .init(),
        data: Data,
        @ViewBuilder content: @escaping (Data.Element) -> Content,
        separator: @escaping () -> Separator
    )
        where
            Data.Element: Identifiable,
            ID == Data.Element.ID
    {
        self.uiModel = uiModel
        self.data = data
        self.id = \.id
        self.content = content
        self.separator = separator
    }
    
    /// Initializes component with constant range and row content.
    public init(
        uiModel: DividedForEachUIModel = .init(),
        data: Data,
        @ViewBuilder content: @escaping (Data.Element) -> Content,
        separator: @escaping () -> Separator
    )
        where
            Data == Range<Int>,
            ID == Int
    {
        self.uiModel = uiModel
        self.data = data
        self.id = \.self
        self.content = content
        self.separator = separator
    }

    // MARK: Body
    public var body: some View {
        ForEach(data, id: id, content: { element in
            let index: Data.Index? = data.firstIndex(of: element)
            
            if
                index == data.startIndex &&
                uiModel.layout.showFirstSeparator
            {
                separator()
            }
            
            content(element)
            
            if index == data.index(before: data.endIndex) {
                if uiModel.layout.showLastSeparator {
                    separator()
                }
            } else {
                separator()
            }
        })
    }
}

// MARK: - Preview
struct DividedForEach_Previews: PreviewProvider {
    static var previews: some View {
        VStack(content: {
            DividedForEach(
                data: Array(0..<20),
                id: \.self,
                content: { Text(String($0)).frame(maxWidth: .infinity, alignment: .leading) },
                separator: Divider.init
            )
        })
            .padding()
    }
}
