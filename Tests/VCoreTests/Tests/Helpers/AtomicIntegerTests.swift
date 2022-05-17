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
        let expectation: XCTestExpectation = expectation(description: "ThreadTest")
        
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
