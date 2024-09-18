//
//  PublisherAssignWeakTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 21.02.24.
//

import Foundation
import Combine
import XCTest
@testable import VCore

// MARK: - Tests
@MainActor
final class PublisherAssignWeakTests: XCTestCase {
    // MARK: Test Data
    private final class SomeClass {
        var value: Int = 0

        private let publisher: PassthroughSubject<Int, Never> = .init()
        private var subscriptions: Set<AnyCancellable> = []

        init() {
            addSubscriptions()
        }

        private func addSubscriptions() {
            publisher
                .assignWeak(to: \.value, on: self)
                .store(in: &subscriptions)
        }
    }

    // MARK: Tests
    func test() async {
        let object: SomeClass = .init()
        assertInstanceIsDeallocated(object)
    }
}
