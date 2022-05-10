//
//  AtomicIntegerTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class AtomicIntegerTests: XCTestCase {
    func testIncrement() {
        let instance: AtomicInteger = .init(initialValue: 0)
        
        XCTAssertEqual(instance.value, 0)
        XCTAssertEqual(instance.value, 1)
    }
    
    func testThreads() {
        let expectation: XCTestExpectation = expectation(description: "ThreadedTest")
        
        let instance: AtomicInteger = .init(initialValue: 0)
        let container: AtomicContainer<Int> = .init()
        
        let count: Int = 10
        count.times { i in
            DispatchQueue.global().async(execute: {
                container.append(instance.value)
                
                if i == count-1 {
                    DispatchQueue.global().async(execute: { expectation.fulfill() })
                }
            })
        }
        
        waitForExpectations(timeout: 10, handler: { _ in
            XCTAssertEqual(container.allElements().count, count)
            XCTAssertTrue(container.allElements().isUnique)
        })
    }
}
 
// MARK: - Atomic Container
private final class AtomicContainer<Value> where Value: Hashable {
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
