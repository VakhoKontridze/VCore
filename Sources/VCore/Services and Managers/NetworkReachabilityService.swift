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
    /// Indicates if device is connected to a network.
    ///
    /// On app launch, property is set to `false`, as `NWPath` is not available,
    private(set) public lazy var isConnectedToNetwork: Bool = false
    
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
        let wasConnectedToNetwork: Bool = isConnectedToNetwork
        isConnectedToNetwork = path.status.isConnected
        
        if
            isConnectedToNetwork != wasConnectedToNetwork ||
            !didCheckStatusForTheFirstTime
        {
            didCheckStatusForTheFirstTime = true
            
            if isConnectedToNetwork {
                NotificationCenter.default.post(name: Self.connectedNotification, object: self, userInfo: nil)
            } else {
                NotificationCenter.default.post(name: Self.disconnectedNotification, object: self, userInfo: nil)
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
        @unknown default: return false
        }
    }
}
