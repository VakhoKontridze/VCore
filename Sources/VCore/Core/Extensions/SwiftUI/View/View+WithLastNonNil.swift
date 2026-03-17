//
//  View+WithLastNonNil.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.08.25.
//

import SwiftUI
import Combine

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
    ///             where Content: View
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
        @ViewBuilder content: @escaping (Self, Item?) -> Content
    ) -> some View
        where Content: View
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
        @ViewBuilder content: @escaping (Root, Item?) -> Content
    ) {
        self.item = item
        self._lastNonNilItem = State(initialValue: item)
        self.root = root
        self.content = content
    }

    // MARK: Body
    var body: some View {
        content(root, item ?? lastNonNilItem)
            .onReceive(Just(item)) { newValue in // Using `Combine` here avoids `Equatable` constraint
                if let newValue {
                    lastNonNilItem = newValue
                }
            }
    }
}
