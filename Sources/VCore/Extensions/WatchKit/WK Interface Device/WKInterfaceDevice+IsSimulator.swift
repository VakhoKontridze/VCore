//
//  WKInterfaceDevice+IsSimulator.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 19.08.24.
//

#if canImport(WatchKit)

import WatchKit

// MARK: - WK Interface Device + Is Simulator
extension WKInterfaceDevice {
    /// Indicates if device is simulator.
    ///
    ///     let isSimulator: Bool = WKInterfaceDevice.isSimulator
    ///
    public static var isSimulator: Bool {
#if targetEnvironment(simulator)
        true
#else
        false
#endif
    }
}

#endif
