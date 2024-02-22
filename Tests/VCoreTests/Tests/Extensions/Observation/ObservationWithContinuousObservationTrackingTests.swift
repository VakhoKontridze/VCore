//
//  ObservationWithContinuousObservationTrackingTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 22.02.24.
//

import Foundation
import Observation
import XCTest
@testable import VCore

// MARK: - Tests
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
final class ObservationWithContinuousObservationTrackingTests: XCTestCase {
    // MARK: Test Data
    @Observable
    /*private*/ final class SomeClass {
        private var input: Int = 1
        fileprivate var output: Int?

        init() {
            addSubscriptions()
        }

        func mutate() {
            input += 1
        }

        private func addSubscriptions() {
            withContinuousObservationTracking(
                of: \.input,
                on: self,
                initial: true,
                execute: { [weak self] in self?.output = $0 }
            )
        }
    }

    // MARK: Tests
    func test() async throws {
        let object: SomeClass = .init()

        try await Task.sleep(seconds: 0.01)
        XCTAssertEqual(object.output, 1)

        object.mutate()
        try await Task.sleep(seconds: 0.01)
        XCTAssertEqual(object.output, 2)

        object.mutate()
        try await Task.sleep(seconds: 0.01)
        XCTAssertEqual(object.output, 3)

        detectMemoryLeak(of: object)
    }
}
