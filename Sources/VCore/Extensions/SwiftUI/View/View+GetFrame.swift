//
//  View+GetFrame.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.09.23.
//

import SwiftUI

// MARK: - View + Get Frame - Coordinate Space
extension View {
    /// Retrieves frame from `View`.
    ///
    ///     @State private var frame: CGRect = .init()
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .getFrame(in: .global, { [$frame] in $frame.wrappedValue = $0 })
    ///     }
    ///
    public func getFrame(
        in coordinateSpace: CoordinateSpace,
        _ action: @escaping @Sendable (CGRect) -> Void
    ) -> some View {
        self
            .background(content: {
                GeometryReader(content: { proxy in
                    Color.clear
                        .preference(
                            key: FramePreferenceKey.self,
                            value: proxy.frame(in: coordinateSpace)
                        )
                        .onPreferenceChange(FramePreferenceKey.self, perform: action)
                })
                .allowsHitTesting(false) // Avoids blocking gestures
            })
    }
    
    /// Retrieves frame from `View` and assigns it on a `Binding`.
    ///
    ///     @State private var frame: CGRect = .init()
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .getFrame(in: .global, assignOn: $frame)
    ///     }
    ///
    public func getFrame(
        in coordinateSpace: CoordinateSpace,
        assignOn binding: Binding<CGRect>
    ) -> some View {
        self
            .getFrame(
                in: coordinateSpace,
                { binding.wrappedValue = $0 }
            )
    }
}
 
// MARK: - View + Get Frame - Coordinate Space Protocol
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension View {
    /// Retrieves frame from `View`.
    ///
    ///     @State private var frame: CGRect = .init()
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .getFrame(in: .global, { [$frame] in $frame.wrappedValue = $0 })
    ///     }
    ///
    public func getFrame(
        in coordinateSpace: some CoordinateSpaceProtocol,
        _ action: @escaping @Sendable (CGRect) -> Void
    ) -> some View {
        self
            .background(content: {
                GeometryReader(content: { proxy in
                    Color.clear
                        .preference(
                            key: FramePreferenceKey.self,
                            value: proxy.frame(in: coordinateSpace)
                        )
                        .onPreferenceChange(FramePreferenceKey.self, perform: action)
                })
                .allowsHitTesting(false) // Avoids blocking gestures
            })
    }
    
    /// Retrieves frame from `View` and assigns it on a `Binding`.
    ///
    ///     @State private var frame: CGRect = .init()
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .getFrame(in: .global, assignOn: $frame)
    ///     }
    ///
    public func getFrame(
        in coordinateSpace: some CoordinateSpaceProtocol,
        assignOn binding: Binding<CGRect>
    ) -> some View {
        self
            .getFrame(
                in: coordinateSpace,
                { binding.wrappedValue = $0 }
            )
    }
}

// MARK: - Frame Preference Key
private struct FramePreferenceKey: PreferenceKey {
    static let defaultValue: CGRect = .init()

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}
