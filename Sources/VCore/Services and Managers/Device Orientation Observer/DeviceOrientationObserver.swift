//
//  DeviceOrientationObserver.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 05.08.23.
//

#if canImport(UIKit) && !(os(tvOS) || os(watchOS))

import SwiftUI
import Combine

// MARK: - Device Orientation Observer
/// Observer that detects changes in device orientation.
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@Observable public final class DeviceOrientationObserver {
    // MARK: Properties
    /// The physical orientation of the device.
    public var deviceOrientation: UIDeviceOrientation = DeviceOrientationObserver.getDeviceOrientation()

    @ObservationIgnored private var subscription: AnyCancellable?

    // MARK: Initializers
    /// Initializes `DeviceOrientationObserver`.
    public init() {
        addSubscriptions()
    }

    deinit {
        subscription?.cancel()
    }

    // MARK: Subscriptions
    private func addSubscriptions() {
        subscription = NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
            .compactMap { _ in Self.getDeviceOrientation() }
            .assign(to: \.deviceOrientation, on: self)
    }

    private static func getDeviceOrientation() -> UIDeviceOrientation {
        UIDevice.current.orientation
    }
}

#endif
