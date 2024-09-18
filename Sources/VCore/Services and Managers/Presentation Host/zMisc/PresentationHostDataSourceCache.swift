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
///         func someModal<T>(
///             layerID: String? = nil,
///             id: String,
///             isPresented: Binding<Bool>,
///             presenting data: T?,
///             @ViewBuilder content: @escaping (T) -> some View
///         ) -> some View {
///             data.map { PresentationHostDataSourceCache.shared.set(key: id, value: $0) }
///
///             return self
///                 .presentationHost(
///                     layerID: layerID,
///                     id: id,
///                     isPresented: isPresented,
///                     presenting: data,
///                     content: {
///                         SomeModal(content: {
///                             if let data = data ?? (PresentationHostDataSourceCache.shared.get(key: id) as? T) {
///                                 content(data)
///                             }
///                         })
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
    private var storage: [String: Any] = [:]
    
    // MARK: Properties - Lock
    private let lock: NSLock = .init()
    
    // MARK: Initializers
    private init() {}
    
    // MARK: Operations
    /// Returns data from key.
    public func get(key: String) -> Any? {
        lock.withLock({
            storage[key]
        })
    }
    
    /// Sets data with key.
    public func set(key: String, value: Any) {
        lock.withLock({
            storage[key] = value
        })
    }
    
    /// Deletes data with key.
    public func remove(key: String) {
        _ = lock.withLock({
            storage.removeValue(forKey: key)
        })
    }
}
