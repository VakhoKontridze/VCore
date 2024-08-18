//
//  UIDevice.IsSimulator.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Device Is Simulator
extension UIDevice {
    /// Indicates if device is simulator.
    ///
    ///     let isSimulator: Bool = UIDevice.isSimulator
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
