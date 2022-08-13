//
//  ObservableContainer.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.08.22.
//

import Foundation

// MARK: - Observable Container
/// Container that wraps value, and conforms to `ObservableObject`.
public final class ObservableContainer<Value>: ObservableObject {
    // MARK: Properties
    /// Wrapped value.
    @Published public var value: Value
    
    // MARK: Initializers
    /// Initializes `ObservableContainer` with value.
    public init(value: Value) {
        self.value = value
    }
}
