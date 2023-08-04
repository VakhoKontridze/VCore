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
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let result1: Int = atomicNumber.get()
        XCTAssertEqual(result1, 10)

        let result2: Int = atomicNumber.get()
        XCTAssertEqual(result2, 10)
    }

    // MARK: Mutators
    func testSet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        atomicNumber.set(20)

        let result: Int = atomicNumber.get()
        XCTAssertEqual(result, 20)
    }

    func testAdd() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        atomicNumber.add(10)

        let result: Int = atomicNumber.get()
        XCTAssertEqual(result, 20)
    }

    func testIncrement() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        atomicNumber.increment()

        let result: Int = atomicNumber.get()
        XCTAssertEqual(result, 11)
    }

    func testDecrement() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        atomicNumber.decrement()

        let result: Int = atomicNumber.get()
        XCTAssertEqual(result, 9)
    }

    // MARK: Get and Pre-Mutators
    func testSetAndGet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let result: Int = atomicNumber.setAndGet(20)
        XCTAssertEqual(result, 20)
    }

    func testAddAndGet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let result: Int = atomicNumber.addAndGet(10)
        XCTAssertEqual(result, 20)
    }

    func testIncrementAndGet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let result: Int = atomicNumber.incrementAndGet()
        XCTAssertEqual(result, 11)
    }

    func testDecrementAndGet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let result: Int = atomicNumber.decrementAndGet()
        XCTAssertEqual(result, 9)
    }

    // MARK: Get and Post-Mutators
    func testGetAndSet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let result1: Int = atomicNumber.getAndSet(20)
        XCTAssertEqual(result1, 10)

        let result2: Int = atomicNumber.get()
        XCTAssertEqual(result2, 20)
    }

    func testGetAndAdd() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let result1: Int = atomicNumber.getAndAdd(10)
        XCTAssertEqual(result1, 10)

        let result2: Int = atomicNumber.get()
        XCTAssertEqual(result2, 20)
    }

    func testGetAndIncrement() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let result1: Int = atomicNumber.getAndIncrement()
        XCTAssertEqual(result1, 10)

        let result2: Int = atomicNumber.get()
        XCTAssertEqual(result2, 11)
    }

    func testGetAndDecrement() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let result1: Int = atomicNumber.getAndDecrement()
        XCTAssertEqual(result1, 10)

        let result2: Int = atomicNumber.get()
        XCTAssertEqual(result2, 9)
    }
}
