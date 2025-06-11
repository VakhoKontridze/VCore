//
//  ModalPresenterDataSourceCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.05.22.
//

import SwiftUI

// MARK: - Modal Presenter Data Source Cache
/// Caches data for Modal Presenter, for when presenting model may become `nil`.
///
/// Can be used to ensure that last content is visible instead of blank screen, when data is set to `nil` and modal is being dismissed.
///
/// For additional info, refer to `View.modalPresenterLink(...)`.
///
///     extension View {
///         func someModal<Item, Content>(
///             link: ModalPresenterLink,
///             item: Binding<Item?>,
///             @ViewBuilder content: @escaping (Item) -> Content
///         ) -> some View
///             where Content: View
///         {
///             item.wrappedValue.map { ModalPresenterDataSourceCache.shared.set(key: id, value: $0) }
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
///                     SomeModal<Content?>(isPresented: isPresented) {
///                         if let item = item.wrappedValue ?? ModalPresenterDataSourceCache.shared.get(key: id) as? Item {
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
    public func get(key: String) -> Any? {
        storage[key]
    }
    
    /// Sets data with key.
    public func set(key: String, value: Any) {
        storage[key] = value
    }
    
    /// Deletes data with key.
    public func remove(key: String) {
        storage.removeValue(forKey: key)
    }
}
