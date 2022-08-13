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
    func testGet() async {
        let atomicInteger: AtomicInteger = .init(value: 10)
        
        let result1: Int = await atomicInteger.get()
        XCTAssertEqual(result1, 10)
        
        let result2: Int = await atomicInteger.get()
        XCTAssertEqual(result2, 10)
    }
    
    func testSet() async {
        let atomicInteger: AtomicInteger = .init(value: 10)
        
        await atomicInteger.set(20)
        
        let result: Int = await atomicInteger.get()
        XCTAssertEqual(result, 20)
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
}
