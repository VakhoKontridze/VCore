//
//  DeviceOrientationObserver.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 05.08.23.
//

#if canImport(UIKit) && !(os(tvOS) || os(watchOS) || os(visionOS))

import Combine
public import SwiftUI

/// Observer that detects changes in device orientation.
///
///     @State private var deviceOrientationObserver: DeviceOrientationObserver = .init()
///
///     var body: some View {
///         Text(deviceOrientationObserver.deviceOrientation.isLandscape ? "Landscape" : "Portrait")
///     }
///
@Observable
public final class DeviceOrientationObserver {
    // MARK: Properties
    /// The physical orientation of the device.
    public var deviceOrientation: UIDeviceOrientation = UIDevice.current.orientation

    @ObservationIgnored private var cancellable: AnyCancellable?

    // MARK: Initializers
    /// Initializes `DeviceOrientationObserver`.
    public init() {
        addSubscriptions()
    }

    // MARK: Subscriptions
    private func addSubscriptions() {
        cancellable = NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
            .compactMap { _ in UIDevice.current.orientation }
            .assignWeak(to: \.deviceOrientation, on: self)
    }
}

#endif
