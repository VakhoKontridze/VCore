//
//  ObservableContainer.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.08.22.
//

import Foundation

// MARK: - Observable Container
/// Container that wraps value, and conforms to `ObservableObject`.
///
/// Can be used to wrap a value in `ObservableObject` without the use of a dedicated ViewModel.
/// Can also be used for passing a reference type in environment, without a dedicated wrapper.
///
///     struct ContentView: Void {
///         @ObservedObject private var viewModel: ObservableContainer<Int> = .init(value: 0)
///
///         var body: some View {
///             ...
///         }
///     }
///
open class ObservableContainer<Value>: ObservableObject {
    // MARK: Properties
    /// Wrapped value.
    @Published open var value: Value
    
    // MARK: Initializers
    /// Initializes `ObservableContainer` with value.
    public init(value: Value) {
        self.value = value
    }
}
