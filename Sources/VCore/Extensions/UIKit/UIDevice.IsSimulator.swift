//
//  UIDevice.IsSimulator.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.22.
//

#if canImport(UIKit)

#if !os(watchOS)

import UIKit

// MARK: - Device Is Simulator
extension UIDevice {
    /// Indicates if device is simulator.
    ///
    /// Usage Example:
    ///
    ///     let isSimulator: Bool = UIDevice.isSimulator
    ///
    public static var isSimulator: Bool {
    #if targetEnvironment(simulator)
        return true
    #else
        return false
    #endif
    }
}

#else

import WatchKit

extension WKInterfaceDevice {
    /// Indicates if device is simulator.
    ///
    /// Usage Example:
    ///
    ///     let isSimulator: Bool = WKInterfaceDevice.isSimulator
    ///
    public static var isSimulator: Bool {
    #if targetEnvironment(simulator)
        return true
    #else
        return false
    #endif
    }
}

#endif

#endif
