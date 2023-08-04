//
//  LockedAtomicIntegerTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.08.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class LockedAtomicIntegerTests: XCTestCase {
    // MARK: Accessors
    func testGet() {
        let atomicInteger: LockedAtomicInteger = .init(value: 10)

        let result1: Int = atomicInteger.get()
        XCTAssertEqual(result1, 10)

        let result2: Int = atomicInteger.get()
        XCTAssertEqual(result2, 10)
    }

    // MARK: Mutators
    func testSet() {
        let atomicInteger: LockedAtomicInteger = .init(value: 10)

        atomicInteger.set(20)

        let result: Int = atomicInteger.get()
        XCTAssertEqual(result, 20)
    }

    func testAdd() {
        let atomicInteger: LockedAtomicInteger = .init(value: 10)

        atomicInteger.add(10)

        let result: Int = atomicInteger.get()
        XCTAssertEqual(result, 20)
    }

    func testIncrement() {
        let atomicInteger: LockedAtomicInteger = .init(value: 10)

        atomicInteger.increment()

        let result: Int = atomicInteger.get()
        XCTAssertEqual(result, 11)
    }

    func testDecrement() {
        let atomicInteger: LockedAtomicInteger = .init(value: 10)

        atomicInteger.decrement()

        let result: Int = atomicInteger.get()
        XCTAssertEqual(result, 9)
    }

    // MARK: Get and Pre-Mutators
    func testSetAndGet() {
        let atomicInteger: LockedAtomicInteger = .init(value: 10)

        let result: Int = atomicInteger.setAndGet(20)
        XCTAssertEqual(result, 20)
    }

    func testAddAndGet() {
        let atomicInteger: LockedAtomicInteger = .init(value: 10)

        let result: Int = atomicInteger.addAndGet(10)
        XCTAssertEqual(result, 20)
    }

    func testIncrementAndGet() {
        let atomicInteger: LockedAtomicInteger = .init(value: 10)

        let result: Int = atomicInteger.incrementAndGet()
        XCTAssertEqual(result, 11)
    }

    func testDecrementAndGet() {
        let atomicInteger: LockedAtomicInteger = .init(value: 10)

        let result: Int = atomicInteger.decrementAndGet()
        XCTAssertEqual(result, 9)
    }

    // MARK: Get and Post-Mutators
    func testGetAndSet() {
        let atomicInteger: LockedAtomicInteger = .init(value: 10)

        let result1: Int = atomicInteger.getAndSet(20)
        XCTAssertEqual(result1, 10)

        let result2: Int = atomicInteger.get()
        XCTAssertEqual(result2, 20)
    }

    func testGetAndAdd() {
        let atomicInteger: LockedAtomicInteger = .init(value: 10)

        let result1: Int = atomicInteger.getAndAdd(10)
        XCTAssertEqual(result1, 10)

        let result2: Int = atomicInteger.get()
        XCTAssertEqual(result2, 20)
    }

    func testGetAndIncrement() {
        let atomicInteger: LockedAtomicInteger = .init(value: 10)

        let result1: Int = atomicInteger.getAndIncrement()
        XCTAssertEqual(result1, 10)

        let result2: Int = atomicInteger.get()
        XCTAssertEqual(result2, 11)
    }

    func testGetAndDecrement() {
        let atomicInteger: LockedAtomicInteger = .init(value: 10)

        let result1: Int = atomicInteger.getAndDecrement()
        XCTAssertEqual(result1, 10)

        let result2: Int = atomicInteger.get()
        XCTAssertEqual(result2, 9)
    }
}
