//
//  LockedAtomicIntegerTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.08.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class LockedAtomicIntegerTests: XCTestCase {
    // MARK: Tests - Accessors
    func testGet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let number1: Int = atomicNumber.get()
        XCTAssertEqual(number1, 10)

        let number2: Int = atomicNumber.get()
        XCTAssertEqual(number2, 10)
    }

    // MARK: Tests - Mutators
    func testSet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        atomicNumber.set(20)

        let number: Int = atomicNumber.get()
        XCTAssertEqual(number, 20)
    }

    func testAdd() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        atomicNumber.add(10)

        let number: Int = atomicNumber.get()
        XCTAssertEqual(number, 20)
    }

    func testIncrement() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        atomicNumber.increment()

        let number: Int = atomicNumber.get()
        XCTAssertEqual(number, 11)
    }

    func testDecrement() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        atomicNumber.decrement()

        let number: Int = atomicNumber.get()
        XCTAssertEqual(number, 9)
    }

    // MARK: Tests - Get and Pre-Mutators
    func testSetAndGet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let number: Int = atomicNumber.setAndGet(20)
        XCTAssertEqual(number, 20)
    }

    func testAddAndGet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let number: Int = atomicNumber.addAndGet(10)
        XCTAssertEqual(number, 20)
    }

    func testIncrementAndGet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let number: Int = atomicNumber.incrementAndGet()
        XCTAssertEqual(number, 11)
    }

    func testDecrementAndGet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let number: Int = atomicNumber.decrementAndGet()
        XCTAssertEqual(number, 9)
    }

    // MARK: Tests - Get and Post-Mutators
    func testGetAndSet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let number1: Int = atomicNumber.getAndSet(20)
        XCTAssertEqual(number1, 10)

        let number2: Int = atomicNumber.get()
        XCTAssertEqual(number2, 20)
    }

    func testGetAndAdd() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let number1: Int = atomicNumber.getAndAdd(10)
        XCTAssertEqual(number1, 10)

        let number2: Int = atomicNumber.get()
        XCTAssertEqual(number2, 20)
    }

    func testGetAndIncrement() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let number1: Int = atomicNumber.getAndIncrement()
        XCTAssertEqual(number1, 10)

        let number2: Int = atomicNumber.get()
        XCTAssertEqual(number2, 11)
    }

    func testGetAndDecrement() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let number1: Int = atomicNumber.getAndDecrement()
        XCTAssertEqual(number1, 10)

        let number2: Int = atomicNumber.get()
        XCTAssertEqual(number2, 9)
    }
}
