//
//  DeviceOrientationObserver.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 05.08.23.
//

#if canImport(UIKit) && !(os(tvOS) || os(watchOS) || os(visionOS))

import SwiftUI
import Combine

// MARK: - Device Orientation Observer
/// Observer that detects changes in device orientation.
///
///     @State private var deviceOrientationObserver: DeviceOrientationObserver = .init()
///
///     var body: some View {
///         Text(deviceOrientationObserver.deviceOrientation.isLandscape ? "Landscape" : "Portrait")
///     }
///
@Observable
@MainActor
public final class DeviceOrientationObserver {
    // MARK: Properties
    /// The physical orientation of the device.
    public var deviceOrientation: UIDeviceOrientation = DeviceOrientationObserver.getDeviceOrientation()

    @ObservationIgnored private var subscription: AnyCancellable?

    // MARK: Initializers
    /// Initializes `DeviceOrientationObserver`.
    public init() {
        addSubscriptions()
    }

    // MARK: Subscriptions
    private func addSubscriptions() {
        subscription = NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
            .compactMap { _ in Self.getDeviceOrientation() }
            .assignWeak(to: \.deviceOrientation, on: self)
    }

    private static func getDeviceOrientation() -> UIDeviceOrientation {
        UIDevice.current.orientation
    }
}

#endif
