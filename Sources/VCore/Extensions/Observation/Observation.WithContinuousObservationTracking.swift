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
///     private final class SomeClass {
///         private var input: Int = 1
///         private(set) var output: Int?
///
///         init() {
///             addSubscriptions()
///         }
///
///         func mutate() {
///             input += 1
///         }
///
///         private func addSubscriptions() {
///             withContinuousObservationTracking(
///                 of: \.input,
///                 on: self,
///                 initial: true,
///                 execute: { [weak self] in self?.output = $0 }
///             )
///         }
///     }
///
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
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

    withObservationTracking(
        { _ = object[keyPath: keyPath] },
        onChange: { [weak object] in
            guard let object else { return }

            Task(operation: { @MainActor in
                block(object[keyPath: keyPath])

                withContinuousObservationTracking(
                    of: keyPath,
                    on: object,
                    initial: false,
                    execute: block
                )
            })
        }
    )
}
