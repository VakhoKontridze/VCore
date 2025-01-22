//
//  LockedAtomicIntegerTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 04.08.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct LockedAtomicIntegerTests {
    // MARK: Tests - Accessors
    @Test
    func testGet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let number1: Int = atomicNumber.get()
        #expect(number1 == 10)

        let number2: Int = atomicNumber.get()
        #expect(number2 == 10)
    }

    @Test
    func testSet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        atomicNumber.set(20)

        let number: Int = atomicNumber.get()
        #expect(number == 20)
    }

    // MARK: Tests - Mutators
    @Test
    func testAdd() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        atomicNumber.add(10)

        let number: Int = atomicNumber.get()
        #expect(number == 20)
    }

    @Test
    func testIncrement() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        atomicNumber.increment()

        let number: Int = atomicNumber.get()
        #expect(number == 11)
    }

    @Test
    func testDecrement() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        atomicNumber.decrement()

        let number: Int = atomicNumber.get()
        #expect(number == 9)
    }

    // MARK: Tests - Get and Pre-Mutators
    @Test
    func testSetAndGet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let number: Int = atomicNumber.setAndGet(20)
        #expect(number == 20)
    }

    @Test
    func testAddAndGet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let number: Int = atomicNumber.addAndGet(10)
        #expect(number == 20)
    }

    @Test
    func testIncrementAndGet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let number: Int = atomicNumber.incrementAndGet()
        #expect(number == 11)
    }

    @Test
    func testDecrementAndGet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let number: Int = atomicNumber.decrementAndGet()
        #expect(number == 9)
    }

    // MARK: Tests - Get and Post-Mutators
    @Test
    func testGetAndSet() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let number1: Int = atomicNumber.getAndSet(20)
        #expect(number1 == 10)

        let number2: Int = atomicNumber.get()
        #expect(number2 == 20)
    }

    @Test
    func testGetAndAdd() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let number1: Int = atomicNumber.getAndAdd(10)
        #expect(number1 == 10)

        let number2: Int = atomicNumber.get()
        #expect(number2 == 20)
    }

    @Test
    func testGetAndIncrement() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let number1: Int = atomicNumber.getAndIncrement()
        #expect(number1 == 10)

        let number2: Int = atomicNumber.get()
        #expect(number2 == 11)
    }

    @Test
    func testGetAndDecrement() {
        let atomicNumber: LockedAtomicInteger = .init(value: 10)

        let number1: Int = atomicNumber.getAndDecrement()
        #expect(number1 == 10)

        let number2: Int = atomicNumber.get()
        #expect(number2 == 9)
    }
}
