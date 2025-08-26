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

@MainActor
final class PublisherAssignWeakTests: XCTestCase {
    // MARK: Tests
    func test() async {
        let service: Service = .init()
        assertInstanceIsDeallocated(service)
    }
    
    // MARK: Types
    private final class Service {
        // MARK: Properties
        var value: Int = 0

        private let publisher: PassthroughSubject<Int, Never> = .init()
        private var cancellables: Set<AnyCancellable> = []

        // MARK: Initializers
        init() {
            addSubscriptions()
        }

        // MARK: Subscriptions
        private func addSubscriptions() {
            publisher
                .assignWeak(to: \.value, on: self)
                .store(in: &cancellables)
        }
    }
}
