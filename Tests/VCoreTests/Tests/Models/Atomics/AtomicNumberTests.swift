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
    // MARK: Accessors
    func testGet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)
        
        let result1: Int = await atomicNumber.get()
        XCTAssertEqual(result1, 10)
        
        let result2: Int = await atomicNumber.get()
        XCTAssertEqual(result2, 10)
    }

    // MARK: Mutators
    func testSet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)
        
        await atomicNumber.set(20)
        
        let result: Int = await atomicNumber.get()
        XCTAssertEqual(result, 20)
    }

    func testAdd() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        await atomicNumber.add(10)

        let result: Int = await atomicNumber.get()
        XCTAssertEqual(result, 20)
    }

    func testIncrement() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        await atomicNumber.increment()

        let result: Int = await atomicNumber.get()
        XCTAssertEqual(result, 11)
    }

    func testDecrement() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        await atomicNumber.decrement()

        let result: Int = await atomicNumber.get()
        XCTAssertEqual(result, 9)
    }

    // MARK: Get and Pre-Mutators
    func testSetAndGet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)
        
        let result: Int = await atomicNumber.setAndGet(20)
        XCTAssertEqual(result, 20)
    }

    func testAddAndGet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        let result: Int = await atomicNumber.addAndGet(10)
        XCTAssertEqual(result, 20)
    }
    
    func testIncrementAndGet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)
        
        let result: Int = await atomicNumber.incrementAndGet()
        XCTAssertEqual(result, 11)
    }
    
    func testDecrementAndGet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)
        
        let result: Int = await atomicNumber.decrementAndGet()
        XCTAssertEqual(result, 9)
    }

    // MARK: Get and Post-Mutators
    func testGetAndSet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        let result1: Int = await atomicNumber.getAndSet(20)
        XCTAssertEqual(result1, 10)

        let result2: Int = await atomicNumber.get()
        XCTAssertEqual(result2, 20)
    }

    func testGetAndAdd() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        let result1: Int = await atomicNumber.getAndAdd(10)
        XCTAssertEqual(result1, 10)

        let result2: Int = await atomicNumber.get()
        XCTAssertEqual(result2, 20)
    }

    func testGetAndIncrement() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        let result1: Int = await atomicNumber.getAndIncrement()
        XCTAssertEqual(result1, 10)

        let result2: Int = await atomicNumber.get()
        XCTAssertEqual(result2, 11)
    }

    func testGetAndDecrement() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        let result1: Int = await atomicNumber.getAndDecrement()
        XCTAssertEqual(result1, 10)

        let result2: Int = await atomicNumber.get()
        XCTAssertEqual(result2, 9)
    }
}
