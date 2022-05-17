//
//  AtomicContainer.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.05.22.
//

import Foundation

// MARK: - Atomic Container
final class AtomicContainer<Value> where Value: Hashable {
    // MARK: Properties
    private let dispatchSemaphore: DispatchSemaphore = .init(value: 1)
    private var storage: [Value]

    // MARK: Initializers
    init() {
        self.storage = []
    }

    // MARK: Methods
    subscript(index: Int) -> Value {
        get {
            dispatchSemaphore.wait()
            defer { dispatchSemaphore.signal() }

            return storage[index]
        }

        set {
            dispatchSemaphore.wait()
            defer { dispatchSemaphore.signal() }

            storage[index] = newValue
        }
    }

    func append(_ element: Value) {
        dispatchSemaphore.wait()
        defer { dispatchSemaphore.signal() }

        storage.append(element)
    }

    func allElements() -> [Value] {
        dispatchSemaphore.wait()
        defer { dispatchSemaphore.signal() }

        return storage
    }
}
