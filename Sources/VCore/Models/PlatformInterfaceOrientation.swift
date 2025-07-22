//
//  PlatformInterfaceOrientation.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.07.25.
//

import SwiftUI

// MARK: - Platform Interface Orientation
/// Platform interface orientation.
public enum PlatformInterfaceOrientation {
    // MARK: Cases
    /// Portrait.
    case portrait
    
    /// Landscape.
    case landscape

    // MARK: Initializers
    /// Initializes `PlatformInterfaceOrientation` from device orientation.
    @MainActor
    public static func initFromDeviceOrientation() -> Self {
#if os(macOS) || os(tvOS) || os(watchOS) || os(visionOS)
        .portrait
#else
        if UIDevice.current.orientation.isLandscape {
            .landscape
        } else {
            .portrait
        }
#endif
    }

#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))
    /// Initializes `PlatformInterfaceOrientation` from interface orientation.
    public init(uiIInterfaceOrientation: UIInterfaceOrientation) {
        self = {
            if uiIInterfaceOrientation.isLandscape {
                .landscape
            } else {
                .portrait
            }
        }()
    }
#endif
}

// MARK: - View + Get Platform Interface Orientation
extension View {
    /// Retrieves `PlatformInterfaceOrientation` from `View`.
    ///
    ///     @State private var interfaceOrientation: PlatformInterfaceOrientation = .initFromDeviceOrientation()
    ///
    ///     var body: some View {
    ///         Text(interfaceOrientation.isLandscape ? "Landscape" : "Portrait")
    ///             .getPlatformInterfaceOrientation { interfaceOrientation = $0 }
    ///     }
    ///
    public func getPlatformInterfaceOrientation(
        _ action: @escaping (PlatformInterfaceOrientation) -> Void
    ) -> some View {
#if os(macOS) || os(tvOS) || os(watchOS) || os(visionOS)
        self
            .onFirstAppear { action(.portrait) }
#else
        self
            .getInterfaceOrientation { action(PlatformInterfaceOrientation(uiIInterfaceOrientation: $0)) }
#endif
    }
}
