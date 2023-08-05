//
//  DeviceOrientationObserver.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 05.08.23.
//

#if os(iOS) || targetEnvironment(macCatalyst)

import UIKit
import Combine

// MARK: - Device Orientation Observer
/// Observer that detects changes in device orientation.
public final class DeviceOrientationObserver: ObservableObject {
    // MARK: Properties
    /// The physical orientation of the device.
    @Published private(set) public var deviceOrientation: UIDeviceOrientation = DeviceOrientationObserver.getDeviceOrientation()

    private var subscription: AnyCancellable?

    // MARK: Initializers
    /// Initializes `DeviceOrientationObserver`.
    public init() {
        setUpObserver()
    }

    deinit {
        subscription?.cancel()
    }

    // MARK: Observers
    private func setUpObserver() {
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
