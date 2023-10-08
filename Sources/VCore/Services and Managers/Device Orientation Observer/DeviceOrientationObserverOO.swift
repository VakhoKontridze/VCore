//
//  DeviceOrientationObserverOO.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 26.09.23.
//

#if canImport(UIKit) && !(os(tvOS) || os(watchOS))

import SwiftUI
import Combine

// MARK: - Device Orientation Observer (Observable Object)
/// Observer that detects changes in device orientation.
public final class DeviceOrientationObserverOO: ObservableObject {
    // MARK: Properties
    /// The physical orientation of the device.
    @Published private(set) public var deviceOrientation: UIDeviceOrientation = DeviceOrientationObserverOO.getDeviceOrientation()

    private var subscription: AnyCancellable?

    // MARK: Initializers
    /// Initializes `DeviceOrientationObserverOO`.
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