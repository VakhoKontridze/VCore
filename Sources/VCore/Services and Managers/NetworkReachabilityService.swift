//
//  NetworkReachabilityService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation
import Network

// MARK: - Network Reachability Service
/// Network connection service that manages reachability.
///
///     NetworkReachabilityService.shared.configure()
///
///     NotificationCenter.default.addObserver(
///         forName: NetworkReachabilityService.connectedNotification,
///         object: nil,
///         queue: .main,
///         using: { _ in self?.presentNoNetworkConnectionScreen() }
///     )
///
///     NotificationCenter.default.addObserver(
///         forName: NetworkReachabilityService.disconnectedNotification,
///         object: nil,
///         queue: .main,
///         using: { _ in self?.dismissNoNetworkConnectionScreen() }
///     )
///
public final class NetworkReachabilityService {
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
    
    // MARK: Properties - Notifications
    /// Name of notification that will be posted when reachability status changes.
    public static var connectedNotification: Notification.Name { .init("NetworkReachabilityService.Connected") }
    
    /// Name of notification that will be posted when reachability status changes.
    public static var disconnectedNotification: Notification.Name { .init("NetworkReachabilityService.Disconnected") }
    
    // MARK: Properties - Monitor
    private lazy var statusMonitor: NWPathMonitor = {
        let monitor: NWPathMonitor = .init()
        monitor.pathUpdateHandler = statusChanged
        return monitor
    }()
    
    private let statusQueue: DispatchQueue = .init(label: "NetworkReachabilityService.StatusQueue")
    
    private var didCheckStatusForTheFirstTime: Bool = false
    
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
            case nil:
                break
                
            case false?:
                NotificationCenter.default.post(name: Self.disconnectedNotification, object: self, userInfo: nil)
                
            case true?:
                NotificationCenter.default.post(name: Self.connectedNotification, object: self, userInfo: nil)
            }
        }
    }
}

// MARK: - Helpers
extension NWPath.Status {
    fileprivate var isConnected: Bool? {
        switch self {
        case .satisfied: return true
        case .unsatisfied: return false
        case .requiresConnection: return false
        @unknown default: return nil
        }
    }
}
