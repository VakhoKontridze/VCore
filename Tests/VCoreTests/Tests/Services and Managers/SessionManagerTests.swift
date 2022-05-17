//
//  SessionManagerTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class SessionManagerTests: XCTestCase {
    // MARK: Test Data
    private let sessionsManger: SessionManager = .init()
    
    // MARK: Tests
    func testValidID() {
        let id: Int = sessionsManger.newSessionID
        XCTAssertTrue(sessionsManger.sessionIsValid(id: id))
    }
    
    func testInvalidID() {
        let id: Int = sessionsManger.newSessionID
        _ = sessionsManger.newSessionID
        XCTAssertFalse(sessionsManger.sessionIsValid(id: id))
    }
    
    func testThreads() {
        let expectation: XCTestExpectation = expectation(description: "ThreadTest")
        
        let container: AtomicContainer<Int> = .init()
        
        let count: Int = 10
        count.times { i in
            DispatchQueue.global().async(execute: { [weak self] in
                guard let self = self else { fatalError() }
                
                let id: Int = self.sessionsManger.newSessionID
                container.append(id)
                
                if i == count-1 {
                    DispatchQueue.global().async(execute: { expectation.fulfill() })
                }
            })
        }
        
        waitForExpectations(timeout: 10, handler: { [weak self] _ in
            guard let self = self else { fatalError() }
            
            XCTAssertEqual(container.allElements().count, count)
            
            XCTAssertTrue(container.allElements().isUnique)
            
            XCTAssertEqual(
                container.allElements().filter { self.sessionsManger.sessionIsValid(id: $0) }.count,
                1
            )
        })
    }
}
