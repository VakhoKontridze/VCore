//
//  PublishingObservationContainer.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 18.04.24.
//

import SwiftUI
import Combine

// MARK: - Publishing Observation Container
/// `Observable` container triggers a `Publisher` when a value changes.
///
/// This container can be used inside non-`View` contexts, such as ViewModels,
/// where continuous observation is not possible. Unlike recursive `withObservationTracking(_:onChange:)`,
/// this container allows for multiple updates in a short timespan.
///
///     @State private var viewModel: ViewModel = .init()
///
///     var body: some View {
///         VStack(content: {
///             Text(String(viewModel.count.value))
///
///             Button("Update", action: {
///                 viewModel.count.value += 1
///                 viewModel.count.value += 1
///             })
///         })
///     }
///
///     @Observable
///     @MainActor
///     final class ViewModel {
///         let count: PublishingObservationContainer<Int> = .init(0)
///
///         @ObservationIgnored private var subscriptions: Set<AnyCancellable> = []
///
///         init() {
///             count
///                 .publisher
///                 .sink(receiveValue: { print($0) })
///                 .store(in: &subscriptions)
///         }
///     }
///
@Observable
@MainActor
public final class PublishingObservationContainer<Value>: Sendable {
    // MARK: Properties - Value
    @ObservationIgnored private var _value: Value
    
    // `init` accessor cannot be used
    /// Value.
    @ObservationIgnored public var value: Value {
        get {
            access(keyPath: \.value)
            return _value
        }
        set {
            withMutation(keyPath: \.value, {
                _value = newValue
            })

            subject.send(newValue)
        }
        _modify {
            access(keyPath: \.value)
            _$observationRegistrar.willSet(self, keyPath: \.value)
            defer { _$observationRegistrar.didSet(self, keyPath: \.value) }
            yield &_value
        }
    }

    // MARK: Properties - Notification
    @ObservationIgnored private let subject: PassthroughSubject<Value, Never> = .init()

    /// `Publisher` that emits when `value` changes.
    @ObservationIgnored public var publisher: AnyPublisher<Value, Never> { subject.eraseToAnyPublisher() }

    // MARK: Initializers
    /// Initializes `PublishingObservationContainer` with value.
    public init(
        _ value: Value
    ) {
        self._value = value
    }
}
