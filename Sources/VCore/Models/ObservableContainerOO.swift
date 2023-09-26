//
//  ObservableContainerOO.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.08.22.
//

import Foundation

// MARK: - Observable Container (Observable Object)
/// Container that wraps value, and conforms to `ObservableObject`.
///
/// Can be used to wrap a value in `ObservableObject` without a dedicated `class`.
///
///     struct ContentView: View {
///         @StateObject private var model: ObservableContainerOO<Int> = .init(value: 0)
///
///         var body: some View {
///             ...
///         }
///     }
///
open class ObservableContainerOO<Value>: ObservableObject {
    // MARK: Properties
    /// Wrapped value.
    @Published open var value: Value
    
    // MARK: Initializers
    /// Initializes `ObservableContainerOO` with value.
    public init(value: Value) {
        self.value = value
    }
}
