//
//  ModalPresenterDataSourceCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.05.22.
//

import SwiftUI

/// Caches data for Modal Presenter, for when presenting model may become `nil`.
///
/// Can be used to ensure that last content is visible instead of blank screen, when data is set to `nil` and modal is being dismissed.
///
/// For additional info, refer to `View.modalPresenterLink(...)`.
///
///     extension View {
///         func modal<Item, Content>(
///             link: ModalPresenterLink,
///             item: Binding<Item?>,
///             @ViewBuilder content: @escaping (Item) -> Content
///         ) -> some View
///             where Content: View
///         {
///             item.wrappedValue.map { ModalPresenterDataSourceCache.shared.set(link: link, value: $0) }
///
///             let isPresented: Binding<Bool> = .init(
///                 get: { item.wrappedValue != nil },
///                 set: { if !$0 { item.wrappedValue = nil } }
///             )
///
///             return self
///                 .modalPresenterLink(
///                     link: link,
///                     isPresented: isPresented,
///                 ) {
///                     Modal<Content?>(isPresented: isPresented) {
///                         if let item = item.wrappedValue ?? ModalPresenterDataSourceCache.shared.get(link: link) as? Item {
///                             content(item)
///                         }
///                     }
///                 }
///         }
///     }
///
@MainActor
public final class ModalPresenterDataSourceCache: Sendable {
    // MARK: Properties - Singleton
    /// Shared instance of `ModalPresenterDataSourceCache`.
    public static let shared: ModalPresenterDataSourceCache = .init()
    
    // MARK: Properties - Storage
    private var storage: [String: Any] = [:]
    
    // MARK: Initializers
    private init() {}
    
    // MARK: Operations
    /// Returns data from key.
    public func get(link: ModalPresenterLink) -> Any? {
        storage[link.key]
    }
    
    /// Sets data with key.
    public func set(link: ModalPresenterLink, value: Any) {
        storage[link.key] = value
    }
    
    /// Deletes data with key.
    public func remove(link: ModalPresenterLink) {
        storage.removeValue(forKey: link.key)
    }
}

extension ModalPresenterLink {
    fileprivate var key: String {
        if let rootID {
            "\(rootID)-\(linkID)"
        } else {
            linkID
        }
    }
}
