//
//  AtomicNumberTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class AtomicNumberTests: XCTestCase {
    // MARK: Tests - Accessors
    func testGet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)
        
        let number1: Int = await atomicNumber.get()
        XCTAssertEqual(number1, 10)
        
        let number2: Int = await atomicNumber.get()
        XCTAssertEqual(number2, 10)
    }

    // MARK: Tests - Mutators
    func testSet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)
        
        await atomicNumber.set(20)
        
        let number: Int = await atomicNumber.get()
        XCTAssertEqual(number, 20)
    }

    func testAdd() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        await atomicNumber.add(10)

        let number: Int = await atomicNumber.get()
        XCTAssertEqual(number, 20)
    }

    func testIncrement() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        await atomicNumber.increment()

        let number: Int = await atomicNumber.get()
        XCTAssertEqual(number, 11)
    }

    func testDecrement() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        await atomicNumber.decrement()

        let number: Int = await atomicNumber.get()
        XCTAssertEqual(number, 9)
    }

    // MARK: Tests - Get and Pre-Mutators
    func testSetAndGet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)
        
        let number: Int = await atomicNumber.setAndGet(20)
        XCTAssertEqual(number, 20)
    }

    func testAddAndGet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        let number: Int = await atomicNumber.addAndGet(10)
        XCTAssertEqual(number, 20)
    }
    
    func testIncrementAndGet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)
        
        let number: Int = await atomicNumber.incrementAndGet()
        XCTAssertEqual(number, 11)
    }
    
    func testDecrementAndGet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)
        
        let number: Int = await atomicNumber.decrementAndGet()
        XCTAssertEqual(number, 9)
    }

    // MARK: Tests - Get and Post-Mutators
    func testGetAndSet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        let number1: Int = await atomicNumber.getAndSet(20)
        XCTAssertEqual(number1, 10)

        let number2: Int = await atomicNumber.get()
        XCTAssertEqual(number2, 20)
    }

    func testGetAndAdd() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        let number1: Int = await atomicNumber.getAndAdd(10)
        XCTAssertEqual(number1, 10)

        let number2: Int = await atomicNumber.get()
        XCTAssertEqual(number2, 20)
    }

    func testGetAndIncrement() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        let number1: Int = await atomicNumber.getAndIncrement()
        XCTAssertEqual(number1, 10)

        let number2: Int = await atomicNumber.get()
        XCTAssertEqual(number2, 11)
    }

    func testGetAndDecrement() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        let number1: Int = await atomicNumber.getAndDecrement()
        XCTAssertEqual(number1, 10)

        let number2: Int = await atomicNumber.get()
        XCTAssertEqual(number2, 9)
    }
}
