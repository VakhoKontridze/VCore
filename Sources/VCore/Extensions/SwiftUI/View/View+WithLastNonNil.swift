//
//  View+WithLastNonNil.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.08.25.
//

import SwiftUI

extension View {
    /// Caches and uses last non-`nil` item when composing content.
    ///
    /// Used for `ModalPresenter` API.
    ///
    ///     extension View {
    ///         func modal<Item, Content>(
    ///             link: ModalPresenterLink,
    ///             item: Binding<Item?>,
    ///             @ViewBuilder content: @escaping (Item) -> Content
    ///         ) -> some View
    ///             where
    ///                 Item: Equatable,
    ///                 Content: View
    ///         {
    ///             let isPresented: Binding<Bool> = .init(
    ///                 get: { item.wrappedValue != nil },
    ///                 set: { if !$0 { item.wrappedValue = nil } }
    ///             )
    ///
    ///             return self
    ///                 .withLastNonNil(item.wrappedValue) { (view, item) in
    ///                     view
    ///                         .modalPresenterLink(
    ///                             link: link,
    ///                             isPresented: isPresented,
    ///                         ) {
    ///                             Modal<Content?>(isPresented: isPresented) {
    ///                                 if let item {
    ///                                     content(item)
    ///                                 }
    ///                             }
    ///                         }
    ///                 }
    ///         }
    ///     }
    ///
    public func withLastNonNil<Item, Content>(
        _ item: Item?,
        content: @escaping (Self, Item?) -> Content
    ) -> some View
        where
            Item: Equatable,
            Content: View
    {
        LastNonNilCachingView(
            item: item,
            root: self,
            content: content
        )
    }
}

private struct LastNonNilCachingView<Item, Root, Content>: View
    where
        Item: Equatable,
        Root: View,
        Content: View
{
    // MARK: Properties
    private let item: Item?
    @State private var lastNonNilItem: Item?
    
    private let root: Root
    
    private let content: (Root, Item?) -> Content
    
    // MARK: Initializers
    init(
        item: Item?,
        root: Root,
        content: @escaping (Root, Item?) -> Content
    ) {
        self.root = root
        self.item = item
        self.content = content
    }

    // MARK: Body
    var body: some View {
        let currentItem: Item? = item ?? lastNonNilItem

        return content(root, currentItem)
            .onChange(of: item, initial: true) { (_, newValue) in
                if let newValue {
                    lastNonNilItem = newValue
                }
            }
    }
}
