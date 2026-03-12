//
//  PlatformInterfaceOrientation.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.07.25.
//

import SwiftUI

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

extension View {
    /// Retrieves `PlatformInterfaceOrientation` from `View`.
    ///
    ///     @State private var interfaceOrientation: PlatformInterfaceOrientation = .initFromDeviceOrientation()
    ///
    ///     var body: some View {
    ///         Text(interfaceOrientation.isLandscape ? "Landscape" : "Portrait")
    ///             .onPlatformInterfaceOrientationChange { interfaceOrientation = $0 }
    ///     }
    ///
    public func onPlatformInterfaceOrientationChange(
        _ action: @escaping (PlatformInterfaceOrientation) -> Void
    ) -> some View {
#if os(macOS) || os(tvOS) || os(watchOS) || os(visionOS)
        self
            .onAppear { isFirst in
                if isFirst {
                    action(.portrait)
                }
            }
#else
        self
            .onInterfaceOrientationChange { action(PlatformInterfaceOrientation(uiIInterfaceOrientation: $0)) }
#endif
    }
}
