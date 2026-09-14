//
//  DefaultNetworkReachabilityService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

public import Foundation
public import Combine
public import Network
import OSLog

/// Object that manages network reachability status.
///
///     @Bindable private var networkReachabilityService: DefaultNetworkReachabilityService = .shared
///
///     var body: some View {
///         Text(networkReachabilityService.status?.isConnected != true ? "Not Connected" : "Connected")
///     }
///
@Observable
nonisolated open class DefaultNetworkReachabilityService: NetworkReachabilityService, @unchecked Sendable {
    // MARK: Properties - Singleton
    /// Shared instance of `DefaultNetworkReachabilityService`.
    public static let shared: DefaultNetworkReachabilityService = .init()
    
    // MARK: Properties - Status
    /// Network connection status.
    open private(set) var status: NWPath.Status? {
        get { queue.sync { _status } }
        set { queue.sync(flags: .barrier) { _status = newValue } }
    }
    
    private var _status: NWPath.Status?
    
    // MARK: Properties - Publishers
    @ObservationIgnored private let statusSubject: CurrentValueSubject<NWPath.Status?, Never> = .init(nil)

    /// `Publisher` that emits when `status` changes.
    @ObservationIgnored public var statusPublisher: AnyPublisher<NWPath.Status?, Never> { statusSubject.eraseToAnyPublisher() }
    
    // MARK: Properties - Status Monitor
    @ObservationIgnored private let statusMonitor: NWPathMonitor = .init()
    
    // MARK: Properties - Queue
    @ObservationIgnored private let queue: DispatchQueue = .init(
        label: "com.vakhtang-kontridze.vcore.default-network-reachability-service",
        attributes: .concurrent
    )
    
    @ObservationIgnored private let statusQueue: DispatchQueue = .init(
        label: "com.vakhtang-kontridze.vcore.default-network-reachability-service.status-queue"
    )

    // MARK: Initializers
    /// Initializes `DefaultNetworkReachabilityService`.
    public init() {
        // `lazy` doesn't work on `nonisolated` properties, so this must be set here
        statusMonitor.pathUpdateHandler = { [weak self] value in
            guard let self else { return }

            let newStatus: NWPath.Status = value.status
            guard newStatus != status else { return }

            status = newStatus
            statusSubject.send(newStatus)
        }
        
        statusMonitor.start(queue: statusQueue)
    }
}
