//
//  AtomicNumberTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct AtomicNumberTests {
    // MARK: Tests - Accessors
    @Test
    func testGet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)
        
        let number1: Int = await atomicNumber.get()
        #expect(number1 == 10)
        
        let number2: Int = await atomicNumber.get()
        #expect(number2 == 10)
    }

    @Test
    func testSet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)
        
        await atomicNumber.set(20)
        
        let number: Int = await atomicNumber.get()
        #expect(number == 20)
    }

    // MARK: Tests - Mutators
    @Test
    func testAdd() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        await atomicNumber.add(10)

        let number: Int = await atomicNumber.get()
        #expect(number == 20)
    }

    @Test
    func testIncrement() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        await atomicNumber.increment()

        let number: Int = await atomicNumber.get()
        #expect(number == 11)
    }

    @Test
    func testDecrement() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        await atomicNumber.decrement()

        let number: Int = await atomicNumber.get()
        #expect(number == 9)
    }

    // MARK: Tests - Get and Pre-Mutators
    @Test
    func testSetAndGet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)
        
        let number: Int = await atomicNumber.setAndGet(20)
        #expect(number == 20)
    }

    @Test
    func testAddAndGet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        let number: Int = await atomicNumber.addAndGet(10)
        #expect(number == 20)
    }
    
    @Test
    func testIncrementAndGet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)
        
        let number: Int = await atomicNumber.incrementAndGet()
        #expect(number == 11)
    }
    
    @Test
    func testDecrementAndGet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)
        
        let number: Int = await atomicNumber.decrementAndGet()
        #expect(number == 9)
    }

    // MARK: Tests - Get and Post-Mutators
    @Test
    func testGetAndSet() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        let number1: Int = await atomicNumber.getAndSet(20)
        #expect(number1 == 10)

        let number2: Int = await atomicNumber.get()
        #expect(number2 == 20)
    }

    @Test
    func testGetAndAdd() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        let number1: Int = await atomicNumber.getAndAdd(10)
        #expect(number1 == 10)

        let number2: Int = await atomicNumber.get()
        #expect(number2 == 20)
    }

    @Test
    func testGetAndIncrement() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        let number1: Int = await atomicNumber.getAndIncrement()
        #expect(number1 == 10)

        let number2: Int = await atomicNumber.get()
        #expect(number2 == 11)
    }

    @Test
    func testGetAndDecrement() async {
        let atomicNumber: AtomicInteger = .init(value: 10)

        let number1: Int = await atomicNumber.getAndDecrement()
        #expect(number1 == 10)

        let number2: Int = await atomicNumber.get()
        #expect(number2 == 9)
    }
}
