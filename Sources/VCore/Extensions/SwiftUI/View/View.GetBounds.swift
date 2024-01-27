//
//  View.GetBounds.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.09.23.
//

import SwiftUI

// MARK: - View Get Bounds
extension View {
    /// Retrieves frame from `View`.
    ///
    ///     @State private var bounds: CGRect?
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .getFrame(of: .global, { frame = $0 })
    ///     }
    ///
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
    public func getBounds(
        of coordinateSpace: NamedCoordinateSpace,
        _ action: @escaping (CGRect?) -> Void
    ) -> some View {
        self
            .background(content: {
                GeometryReader(content: { proxy in
                    Color.clear
                        .preference(
                            key: BoundsPreferenceKey.self,
                            value: proxy.bounds(of: coordinateSpace)
                        )
                        .onPreferenceChange(BoundsPreferenceKey.self, perform: action)
                })
            })
    }
}

// MARK: - Frame Preference Key
private struct BoundsPreferenceKey: PreferenceKey {
    static let defaultValue: CGRect? = nil

    static func reduce(value: inout CGRect?, nextValue: () -> CGRect?) {}
}
