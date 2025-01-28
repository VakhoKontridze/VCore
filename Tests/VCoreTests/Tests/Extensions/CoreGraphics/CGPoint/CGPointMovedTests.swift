//
//  CGPointMovedTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.09.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct CGPointMovedTests {
    @Test
    func testMovedLeft() {
        #expect(
            CGPoint(x: 3, y: 4).movedLeft(withValue: 1) ==
            CGPoint(x: 2, y: 4)
        )
        
        do {
            var point: CGPoint = .init(x: 3, y: 4)
            point.moveLeft(withValue: 1)
            
            #expect(point == CGPoint(x: 2, y: 4))
        }
    }
    
    @Test
    func testMovedRight() {
        #expect(
            CGPoint(x: 3, y: 4).movedRight(withValue: 1) ==
            CGPoint(x: 4, y: 4)
        )
        
        do {
            var point: CGPoint = .init(x: 3, y: 4)
            point.moveRight(withValue: 1)
            
            #expect(point == CGPoint(x: 4, y: 4))
        }
    }

    @Test
    func testMovedUp() {
        #expect(
            CGPoint(x: 3, y: 4).movedUp(withValue: 1) ==
            CGPoint(x: 3, y: 3)
        )
        
        do {
            var point: CGPoint = .init(x: 3, y: 4)
            point.moveUp(withValue: 1)
            
            #expect(point == CGPoint(x: 3, y: 3))
        }
    }

    @Test
    func testMovedDown() {
        #expect(
            CGPoint(x: 3, y: 4).movedDown(withValue: 1) ==
            CGPoint(x: 3, y: 5)
        )
        
        do {
            var point: CGPoint = .init(x: 3, y: 4)
            point.moveDown(withValue: 1)
            
            #expect(point == CGPoint(x: 3, y: 5))
        }
    }
}
