//
//  AsyncStreamingObservationContainer.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.07.25.
//

import Foundation

/// `Observable` container that triggers a `AsyncStream` when a value changes.
///
/// This container can be used inside non-`View` contexts, such as ViewModels,
/// where continuous observation is not possible. Unlike recursive `withObservationTracking(_:onChange:)`,
/// this container allows for multiple updates in a short timespan.
///
///     @State private var viewModel: ViewModel = .init()
///
///     var body: some View {
///         VStack {
///             Text(String(viewModel.count.value))
///
///             Button("Update") {
///                 viewModel.count.value += 1
///                 viewModel.count.value += 1
///             }
///         }
///     }
///
///     @Observable
///     final class ViewModel {
///         let count: AsyncStreamingObservationContainer<Int> = .init(0)
///
///         init() {
///             Task {
///                 for await value in count.asyncStream {
///                     print(value)
///                 }
///             }
///         }
///     }
///
@Observable
public final class AsyncStreamingObservationContainer<Value> where Value: Sendable {
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
            withMutation(keyPath: \.value) {
                _value = newValue
            }

            for continuation in continuations {
                continuation.continuation.yield(newValue)
            }
        }
    }

    // MARK: Properties - Async Stream
    @ObservationIgnored private var continuations: [ContinuationHolder<Value>] = []

    /// AsyncStream` that emits values on each change.
    @ObservationIgnored public var asyncStream: AsyncStream<Value> {
        .init { continuation in
            let continuationHolder: ContinuationHolder = .init(continuation)
            continuations.append(continuationHolder)
            
            continuation.onTermination = { [weak self, continuationHolder] _ in
                guard let self else { return }
                
                Task { @MainActor in
                    continuations.removeAll { $0 === continuationHolder }
                }
            }
        }
    }

    // MARK: Initializers
    /// Initializes `AsyncStreamingObservationContainer` with value.
    public init(_ value: Value) {
        self._value = value
    }
    
    deinit {
        for continuation in continuations {
            continuation.continuation.finish()
        }
    }
}

private nonisolated final class ContinuationHolder<Value>: Sendable {
    // MARK: Properties
    let continuation: AsyncStream<Value>.Continuation

    // MARK: Initializers
    init(_ continuation: AsyncStream<Value>.Continuation) {
        self.continuation = continuation
    }
}

#if DEBUG

import SwiftUI

#Preview {
    @Previewable @State var viewModel: ViewModel = .init()

    VStack {
        Text(String(viewModel.count.value))

        Button("Update") {
            viewModel.count.value += 1
            viewModel.count.value += 1
        }
    }
}

@Observable
private final class ViewModel {
    // MARK: Properties
    let count: AsyncStreamingObservationContainer<Int> = .init(0)

    // MARK: Initializers
    init() {
        Task {
            for await value in count.asyncStream {
                print(value)
            }
        }
    }
}

#endif
