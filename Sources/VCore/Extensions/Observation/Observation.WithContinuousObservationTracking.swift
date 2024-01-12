//
//  Observation.WithContinuousObservationTracking.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.11.23.
//

import Foundation
import Observation

// MARK: - Observation with Continuous Observation Tracking
/// Tracks access to properties in a `class` type continuously.
///
///     @Observable
//      final class SomeObject {
///         private var value: Int = 0
///
///         init() {
///             addSubscriptions()
///         }
///
///         private func addSubscriptions() {
///             withContinuousObservationTracking(
///                 of: \.value,
///                 on: self,
///                 execute: { print($0) }
///             )
///         }
///     }
///
@available(iOS 17.0, macOS 14.0, watchOS 10.0, tvOS 17.0, *)
public func withContinuousObservationTracking<Object, T>(
    of keyPath: KeyPath<Object, T>,
    on object: Object,
    initial: Bool = false,
    execute block: @escaping @Sendable (T) -> Void
)
    where Object: AnyObject
{
    if initial {
        block(object[keyPath: keyPath])
    }

    _withContinuousObservationTracking(
        of: keyPath,
        on: object,
        execute: block
    )
}

@available(iOS 17.0, macOS 14.0, watchOS 10.0, tvOS 17.0, *)
private func _withContinuousObservationTracking<Object, T>(
    of keyPath: KeyPath<Object, T>,
    on object: Object,
    execute block: @escaping @Sendable (T) -> Void
)
    where Object: AnyObject
{
    withObservationTracking(
        { _ = object[keyPath: keyPath] },
        onChange: { [weak object] in
            guard let object else { return }

            DispatchQueue.main.async(execute: {
                block(object[keyPath: keyPath])

                _withContinuousObservationTracking(
                    of: keyPath,
                    on: object,
                    execute: block
                )
            })
        }
    )
}
