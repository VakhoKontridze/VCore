//
//  NetworkReachabilityService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation
import Combine
import Network
import OSLog

// MARK: - Network Reachability Service
/// Network connection service that manages reachability.
///
///     NetworkReachabilityService.shared.configure()
///
///     NetworkReachabilityService.shared
///         .connectedPublisher
///         .sink(receiveValue: { [weak self] in self?.presentNoNetworkConnectionScreen() })
///         .store(in: &subscriptions)
///
///     NetworkReachabilityService.shared
///         .disconnectedPublisher
///         .sink(receiveValue: { [weak self] in self?.dismissNoNetworkConnectionScreen() })
///         .store(in: &subscriptions)
///
public final class NetworkReachabilityService { // TODO: iOS 17 - Convert to `Observable` and remove `Combine`
    // MARK: Properties - Singleton
    /// Shared instance of `NetworkReachabilityService`.
    public static let shared: NetworkReachabilityService = .init()
    
    // MARK: Properties - Status
    /// Network connection status.
    private(set) public var status: NWPath.Status?
    
    /// Indicates if device is connected to a network.
    ///
    /// On app launch, `nil` is returned.
    public var isConnectedToNetwork: Bool? { status?.isConnected }
    
    // MARK: Properties - Status Monitor
    private lazy var statusMonitor: NWPathMonitor = {
        let monitor: NWPathMonitor = .init()
        monitor.pathUpdateHandler = statusChanged
        return monitor
    }()
    
    private let statusQueue: DispatchQueue = .init(label: "NetworkReachabilityService.StatusQueue")
    
    private var didCheckStatusForTheFirstTime: Bool = false

    // MARK: Properties - Publishers
    /// `Publisher` that emits when device connects to the network.
    public let connectedPublisher: PassthroughSubject<Void, Never> = .init()

    /// `Publisher` that emits when device disconnects from the network.
    public let disconnectedPublisher: PassthroughSubject<Void, Never> = .init()

    // MARK: Initializers
    private init() {
        statusMonitor.start(queue: statusQueue)
    }
    
    // MARK: Configuration
    /// Configures `NetworkReachabilityService`.
    public func configure() {
        _ = Self.shared
    }
    
    // MARK: Status
    private func statusChanged(_ path: NWPath) {
        let oldStatus = status
        status = path.status
        
        if status != oldStatus || !didCheckStatusForTheFirstTime {
            didCheckStatusForTheFirstTime = true
            
            switch isConnectedToNetwork {
            case nil: break
            case false?: disconnectedPublisher.send()
            case true?: connectedPublisher.send()
            }
        }
    }
}

// MARK: - Helpers
extension NWPath.Status {
    fileprivate var isConnected: Bool {
        switch self {
        case .satisfied: return true
        case .unsatisfied: return false
        case .requiresConnection: return false
        @unknown default: 
            Logger.networkReachabilityService.fault("Unhandled 'NWPath.Status' '\(String(describing: self))' in 'NWPath.Status.isConnected'")
            return false
        }
    }
}
