//
//  Publisher.AssignWeak.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11.11.23.
//

import Foundation
import Combine

// MARK: - Publisher Assign Weak
extension Publisher where Failure == Never {
    /// Assigns each element from a `Publisher` to a property of an object with a weak retain cycle.
    ///
    ///     final class SomeClass {
    ///         var value: Int = 0
    ///
    ///         private let publisher: PassthroughSubject<Int, Never> = .init()
    ///         private var subscriptions: Set<AnyCancellable> = []
    ///
    ///         init() {
    ///             addSubscriptions()
    ///         }
    ///
    ///         private func addSubscriptions() {
    ///             publisher
    ///                 .assignWeak(to: \.value, on: self)
    ///                 .store(in: &subscriptions)
    ///         }
    ///     }
    ///
    public func assignWeak<Root>(
        to keyPath: ReferenceWritableKeyPath<Root, Output>,
        on object: Root
    ) -> AnyCancellable 
        where Root: AnyObject
    {
        sink(receiveValue: { [weak object] value in
            guard let object else { return }

            object[keyPath: keyPath] = value
        })
    }
}
