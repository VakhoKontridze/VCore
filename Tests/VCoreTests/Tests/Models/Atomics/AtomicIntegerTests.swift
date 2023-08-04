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
    // MARK: Accessors
    func testGet() async {
        let atomicInteger: AtomicInteger = .init(value: 10)
        
        let result1: Int = await atomicInteger.get()
        XCTAssertEqual(result1, 10)
        
        let result2: Int = await atomicInteger.get()
        XCTAssertEqual(result2, 10)
    }

    // MARK: Mutators
    func testSet() async {
        let atomicInteger: AtomicInteger = .init(value: 10)
        
        await atomicInteger.set(20)
        
        let result: Int = await atomicInteger.get()
        XCTAssertEqual(result, 20)
    }

    func testAdd() async {
        let atomicInteger: AtomicInteger = .init(value: 10)

        await atomicInteger.add(10)

        let result: Int = await atomicInteger.get()
        XCTAssertEqual(result, 20)
    }

    func testIncrement() async {
        let atomicInteger: AtomicInteger = .init(value: 10)

        await atomicInteger.increment()

        let result: Int = await atomicInteger.get()
        XCTAssertEqual(result, 11)
    }

    func testDecrement() async {
        let atomicInteger: AtomicInteger = .init(value: 10)

        await atomicInteger.decrement()

        let result: Int = await atomicInteger.get()
        XCTAssertEqual(result, 9)
    }

    // MARK: Get and Pre-Mutators
    func testSetAndGet() async {
        let atomicInteger: AtomicInteger = .init(value: 10)
        
        let result: Int = await atomicInteger.setAndGet(20)
        XCTAssertEqual(result, 20)
    }

    func testAddAndGet() async {
        let atomicInteger: AtomicInteger = .init(value: 10)

        let result: Int = await atomicInteger.addAndGet(10)
        XCTAssertEqual(result, 20)
    }
    
    func testIncrementAndGet() async {
        let atomicInteger: AtomicInteger = .init(value: 10)
        
        let result: Int = await atomicInteger.incrementAndGet()
        XCTAssertEqual(result, 11)
    }
    
    func testDecrementAndGet() async {
        let atomicInteger: AtomicInteger = .init(value: 10)
        
        let result: Int = await atomicInteger.decrementAndGet()
        XCTAssertEqual(result, 9)
    }

    // MARK: Get and Post-Mutators
    func testGetAndSet() async {
        let atomicInteger: AtomicInteger = .init(value: 10)

        let result1: Int = await atomicInteger.getAndSet(20)
        XCTAssertEqual(result1, 10)

        let result2: Int = await atomicInteger.get()
        XCTAssertEqual(result2, 20)
    }

    func testGetAndAdd() async {
        let atomicInteger: AtomicInteger = .init(value: 10)

        let result1: Int = await atomicInteger.getAndAdd(10)
        XCTAssertEqual(result1, 10)

        let result2: Int = await atomicInteger.get()
        XCTAssertEqual(result2, 20)
    }

    func testGetAndIncrement() async {
        let atomicInteger: AtomicInteger = .init(value: 10)

        let result1: Int = await atomicInteger.getAndIncrement()
        XCTAssertEqual(result1, 10)

        let result2: Int = await atomicInteger.get()
        XCTAssertEqual(result2, 11)
    }

    func testGetAndDecrement() async {
        let atomicInteger: AtomicInteger = .init(value: 10)

        let result1: Int = await atomicInteger.getAndDecrement()
        XCTAssertEqual(result1, 10)

        let result2: Int = await atomicInteger.get()
        XCTAssertEqual(result2, 9)
    }
}
