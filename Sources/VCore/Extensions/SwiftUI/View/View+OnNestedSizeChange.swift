//
//  View+OnNestedSizeChange.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12.10.23.
//

import SwiftUI

extension View {
    /// Adds an action to be performed when size from nested child changed.
    ///
    /// Can be used for wrapping `TabView` to it's content.
    ///
    ///     @State private var height: CGFloat = 0
    ///
    ///     var body: some View {
    ///         TabView {
    ///             ForEach(0..<3, id: \.self) { i in
    ///                 Text("Page \(i+1)")
    ///                     .nestedSizeTargetLayout()
    ///             }
    ///         }
    ///         .tabViewStyle(.page(indexDisplayMode: .never))
    ///         .background(Color.gray)
    ///
    ///         .onNestedSizeChange { [$height] in $height.wrappedValue = max($0.height, 1) }  // `1` creates a non-zero buffer before height calculates
    ///         .frame(height: height)
    ///         .padding()
    ///     }
    ///
    public func onNestedSizeChange(
        action: @escaping (CGSize) -> Void
    ) -> some View {
        self
            .onPreferenceChange(NestedSizePreferenceKey.self, perform: action)
    }
    
    /// Retrieves nested nested size from child `View` and assigns it on a `Binding`.
    ///
    /// For additional info, refer to `View.getNestedSize(_:)` method.
    public func onNestedSizeChange(
        assignTo binding: Binding<CGSize>
    ) -> some View {
        self
            .onNestedSizeChange { binding.wrappedValue = $0 }
    }
}

extension View {
    /// Configures `View` as a target layout for reading nested size via `getNestedSize(_:)` method.
    public func nestedSizeTargetLayout() -> some View {
        self
            .background {
                GeometryReader { geometryProxy in
                    Color.clear
                        .preference(
                            key: NestedSizePreferenceKey.self,
                            value: geometryProxy.size
                        )
                }
                .allowsHitTesting(false) // Avoids blocking gestures
            }
    }
}

private struct NestedSizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

#if DEBUG

#if !os(macOS) // No `PageTabViewStyle` on macOS

#Preview {
    @Previewable @State var height: CGFloat = 0

    TabView {
        ForEach(0..<3, id: \.self) { i in
            Text("Page \(i+1)")
                .nestedSizeTargetLayout()
        }
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
    .background(Color.gray)

    .onNestedSizeChange { [$height] in $height.wrappedValue = max($0.height, 1) } // `1` creates a non-zero buffer before height calculates
    .frame(height: height)
    .padding()
}

#endif

#endif
