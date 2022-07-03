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
/// On `watchOS`, `isConnectedToNetwork` will return `nil` on app launch.
public final class NetworkReachabilityService {
    // MARK: Properties
    #if !os(watchOS)
    /// Indicates if device is connected to a network.
    public var isConnectedToNetwork: Bool { SocketConnectionNetworkReachabilityService.shared.isConnectedToNetwork }

    #else
        
    /// Indicates if device is connected to a network.
    ///
    /// On app launch, property is set to `false`, as `NWPath` is not available,
    private(set) public lazy var isConnectedToNetwork: Bool = false

    #endif
    
    /// Name of notification that will be posted when reachability status changes.
    public static var connectedNotification: NSNotification.Name { .init("NetworkReachabilityService.Connected") }
    
    /// Name of notification that will be posted when reachability status changes.
    public static var disconnectedNotification: NSNotification.Name { .init("NetworkReachabilityService.Disconnected") }
    
    private lazy var statusMonitor: NWPathMonitor = {
        let monitor: NWPathMonitor = .init()
        monitor.pathUpdateHandler = statusChanged
        return monitor
    }()
    
    private let statusQueue: DispatchQueue = .init(label: "NetworkReachabilityService.StatusQueue")
    
    /// Shared instance of `NetworkReachabilityService`.
    public static let shared: NetworkReachabilityService = .init()
    
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
        guard isConnectedToNetwork != path.status.isConnected else { return }
            
        #if os(watchOS)
        isConnectedToNetwork = path.status.isConnected
        #endif
        
        switch isConnectedToNetwork {
        case false: NotificationCenter.default.post(name: Self.disconnectedNotification, object: self, userInfo: nil)
        case true: NotificationCenter.default.post(name: Self.connectedNotification, object: self, userInfo: nil)
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
        @unknown default: return false
        }
    }
}
