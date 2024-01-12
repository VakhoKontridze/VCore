//
//  PresentationHostDataSourceCache.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.05.22.
//

import SwiftUI

// MARK: - Presentation Host Data Source Cache
/// Caches data for Presentation Host, for when it may become `nil`.
///
/// Can be used to ensure that last content is visible instead of blank screen, when data is set to `nil` and modal is being dismissed.
///
/// For additional info, refer to `View.presentationHost(id:allowsHitTests:isPresented:content:)`.
///
///     extension View {
///         func someModal<T>(
///             id: String,
///             isPresented: Binding<Bool>,
///             presenting data: T?,
///             @ViewBuilder content: @escaping (T) -> some View
///         ) -> some View {
///             data.map { PresentationHostDataSourceCache.shared.set(key: id, value: $0) }
///
///             return self
///                 .presentationHost(
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
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public final class PresentationHostDataSourceCache {
    // MARK: Properties
    /// Shared instance of `PresentationHostDataSourceCache`.
    public static let shared: PresentationHostDataSourceCache = .init()
    
    private var storage: [String: Any] = [:]
    
    // MARK: Initializers
    private init() {}
    
    // MARK: Get and Set
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
