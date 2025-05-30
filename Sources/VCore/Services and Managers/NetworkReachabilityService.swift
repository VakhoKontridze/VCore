//
//  NetworkReachabilityService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation
import Network
import OSLog

// MARK: - Network Reachability Service
/// Network connection service that manages reachability.
///
///     @Bindable private var networkReachabilityService: NetworkReachabilityService = .shared
///
///     var body: some View {
///         Text(networkReachabilityService.isConnectedToNetwork != true ? "Not Connected" : "Connected")
///     }
///
@Observable
public final class NetworkReachabilityService: @unchecked Sendable {
    // MARK: Properties - Singleton
    /// Shared instance of `NetworkReachabilityService`.
    public static let shared: NetworkReachabilityService = .init()
    
    // MARK: Properties - Status
    private var _status: NWPath.Status?
    
    /// Network connection status.
    private(set) public var status: NWPath.Status? {
        get { lock.withLock({ _status }) }
        set { lock.withLock({ _status = newValue }) }
    }
    
    /// Indicates if device is connected to a network.
    ///
    /// On app launch, `nil` is returned.
    public var isConnectedToNetwork: Bool? { status?.isConnected }
    
    // MARK: Properties - Status Monitor
    @ObservationIgnored private lazy var statusMonitor: NWPathMonitor = {
        let monitor: NWPathMonitor = .init()
        
        monitor.pathUpdateHandler = { newValue in
            Task(operation: { @MainActor in
                self.status = newValue.status
            })
        }
        
        return monitor
    }()
    
    @ObservationIgnored private let statusQueue: DispatchQueue = .init(label: "NetworkReachabilityService.StatusQueue")
    
    // MARK: Properties - Lock
    private let lock: NSLock = .init()

    // MARK: Initializers
    private init() {
        statusMonitor.start(queue: statusQueue)
    }
    
    // MARK: Configuration
    /// Configures `NetworkReachabilityService`.
    public func configure() {
        _ = Self.shared
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
