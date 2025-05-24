//
//  PresentationHostDataSourceCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.05.22.
//

import SwiftUI

// MARK: - Presentation Host Data Source Cache
/// Caches data for Presentation Host, for when presenting model may become `nil`.
///
/// Can be used to ensure that last content is visible instead of blank screen, when data is set to `nil` and modal is being dismissed.
///
/// For additional info, refer to `View.presentationHost(...)`.
///
///     extension View {
///         func someModal<Item, Content>(
///             layerID: String? = nil,
///             id: String,
///             item: Binding<Item?>,
///             @ViewBuilder content: @escaping (Item) -> Content
///         ) -> some View
///             where Content: View
///         {
///             item.wrappedValue.map { PresentationHostDataSourceCache.shared.set(key: id, value: $0) }
///
///             let isPresented: Binding<Bool> = .init(
///                 get: { item.wrappedValue != nil },
///                 set: { if !$0 { item.wrappedValue = nil } }
///             )
///
///             return self
///                 .presentationHost(
///                     layerID: layerID,
///                     id: id,
///                     isPresented: isPresented,
///                     content: {
///                         SomeModal<Content?>(
///                             isPresented: isPresented,
///                             content: {
///                                 if let item = item.wrappedValue ?? PresentationHostDataSourceCache.shared.get(key: id) as? Item {
///                                     content(item)
///                                 }
///                             }
///                         )
///                     }
///                 )
///         }
///     }
///
public final class PresentationHostDataSourceCache: @unchecked Sendable {
    // MARK: Properties - Singleton
    /// Shared instance of `PresentationHostDataSourceCache`.
    public static let shared: PresentationHostDataSourceCache = .init()
    
    // MARK: Properties - Storage
    private var _storage: [String: Any] = [:]
    
    private var storage: [String: Any] {
        get { lock.withLock({ _storage }) }
        set { lock.withLock({ _storage = newValue }) }
    }
    
    // MARK: Properties - Lock
    private let lock: NSLock = .init()
    
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
