//
//  NetworkReachabilityService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

#if !os(watchOS)

import Foundation
import Network
import SystemConfiguration

// MARK: - Network Reachability Service
/// Network connection service that manages reachability.
public struct NetworkReachabilityService {
    // MARK: Properties
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
    public static let shared: Self = .init()
    
    // MARK: Initializers
    private init() {
        statusMonitor.start(queue: statusQueue)
    }
    
    // MARK: Configuration
    /// Configures `NetworkReachabilityService`.
    public static func configure() {
        _ = Self.shared
    }
    
    // MARK: Status
    private func statusChanged(_ path: NWPath) {
        switch path.status {
        case .satisfied: postNotification(name: Self.connectedNotification)
        case .unsatisfied: postNotification(name: Self.disconnectedNotification)
        case .requiresConnection: postNotification(name: Self.disconnectedNotification)
        @unknown default: postNotification(name: Self.disconnectedNotification)
        }
    }
    
    private func postNotification(name: NSNotification.Name) {
        NotificationCenter.default.post(
            name: name,
            object: self,
            userInfo: nil
        )
    }

    // MARK: Connection
    /// Indicates if device is connected to a network.
    public static var isConnectedToNetwork: Bool {
        var zeroAddress: sockaddr_in = {
            var zeroAddress: sockaddr_in = .init()
            zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
            zeroAddress.sin_family = sa_family_t(AF_INET)
            return zeroAddress
        }()

        guard
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, { address in
                address.withMemoryRebound(to: sockaddr.self, capacity: 1, { address2 in
                    SCNetworkReachabilityCreateWithAddress(nil, address2)
                })
            })
        else {
            return false
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) { return false }
        
        guard !flags.isEmpty else { return false }

        let isReachable: Bool = flags.contains(.reachable)
        let needsConnection: Bool = flags.contains(.connectionRequired)
        let isConnected: Bool = isReachable && !needsConnection

        return isConnected
    }
}

#endif
