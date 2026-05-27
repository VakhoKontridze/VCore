//
//  DefaultNetworkReachabilityService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

public import Foundation
public import Network
import OSLog

/// Object that manages network reachability status.
///
///     @Bindable private var networkReachabilityService: DefaultNetworkReachabilityService = .shared
///
///     var body: some View {
///         Text(networkReachabilityService.isConnectedToNetwork != true ? "Not Connected" : "Connected")
///     }
///
@Observable
nonisolated open class DefaultNetworkReachabilityService: NetworkReachabilityService, @unchecked Sendable {
    // MARK: Properties - Singleton
    /// Shared instance of `DefaultNetworkReachabilityService`.
    public static let shared: DefaultNetworkReachabilityService = .init()
    
    // MARK: Properties - Status
    open private(set) var status: NWPath.Status? {
        get { queue.sync { _status } }
        set { queue.sync(flags: .barrier) { _status = newValue } }
    }
    private var _status: NWPath.Status?
    
    open var isConnectedToNetwork: Bool? { status?.isConnected }
    
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
        statusMonitor.pathUpdateHandler = { [weak self] in self?.status = $0.status }
        
        statusMonitor.start(queue: statusQueue)
    }
}

nonisolated extension NWPath.Status {
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
