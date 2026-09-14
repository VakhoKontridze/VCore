//
//  NetworkReachabilityService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27/5/26.
//

public import Combine
import Foundation
public import Network

@Observable
nonisolated open class MockNetworkReachabilityService: NetworkReachabilityService, @unchecked Sendable {
    // MARK: Properties - Status
    /// Network connection status.
    ///
    /// Mutating this value emits it through `statusPublisher`.
    open var status: NWPath.Status? {
        didSet { statusSubject.send(status) }
    }

    // MARK: Properties - Notification
    @ObservationIgnored private let statusSubject: CurrentValueSubject<NWPath.Status?, Never>

    /// `Publisher` that emits when `status` changes.
    @ObservationIgnored public var statusPublisher: AnyPublisher<NWPath.Status?, Never> { statusSubject.eraseToAnyPublisher() }

    // MARK: Initializers
    /// Initializes `MockNetworkReachabilityService`.
    public init(
        status: NWPath.Status? = .satisfied
    ) {
        self.statusSubject = .init(status)
        self.status = status
    }
}
