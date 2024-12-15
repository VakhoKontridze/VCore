//
//  View+GetNestedSize.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12.10.23.
//

import SwiftUI

// MARK: - View + Get Nested Size
extension View {
    /// Retrieves nested nested size from child `View`.
    ///
    /// Can be used for wrapping `TabView` to it's content.
    ///
    ///     @State private var height: CGFloat = 0
    ///
    ///     var body: some View {
    ///         TabView(content: {
    ///             ForEach(0..<3, id: \.self, content: { i in
    ///                 Text("Page \(i+1)")
    ///                     .nestedSizeTargetLayout()
    ///             })
    ///         })
    ///         .tabViewStyle(.page(indexDisplayMode: .never))
    ///         .background(content: { Color.gray })
    ///
    ///         .getNestedSize({ [$height] in $height.wrappedValue = max($0.height, 1) }) // `1` creates a non-zero buffer before height calculates
    ///         .frame(height: height)
    ///         .padding()
    ///     }
    ///
    public func getNestedSize(
        _ action: @escaping @Sendable (CGSize) -> Void
    ) -> some View {
        self
            .onPreferenceChange(NestedSizePreferenceKey.self, perform: action)
    }
    
    /// Retrieves nested nested size from child `View` and assigns it on a `Binding`.
    ///
    /// For more info, refer to `View.getNestedSize(_:)` method.
    public func getNestedSize(
        assignTo binding: Binding<CGSize>
    ) -> some View {
        self
            .getNestedSize({ binding.wrappedValue = $0 })
    }
}

extension View {
    /// Configures `View` as a target layout for reading nested `CGSize` via `getNestedSize(_:)` method.
    public func nestedSizeTargetLayout() -> some View {
        self
            .background(content: {
                GeometryReader(content: { proxy in
                    Color.clear
                        .preference(
                            key: NestedSizePreferenceKey.self,
                            value: proxy.size
                        )
                })
                .allowsHitTesting(false) // Avoids blocking gestures
            })
    }
}

// MARK: - Nested Size Preference Key
private struct NestedSizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

// MARK: - Preview
#if DEBUG

#if !os(macOS)

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview(body: {
    @Previewable @State var height: CGFloat = 0

    TabView(content: {
        ForEach(0..<3, id: \.self, content: { i in
            Text("Page \(i+1)")
                .nestedSizeTargetLayout()
        })
    })
    .tabViewStyle(.page(indexDisplayMode: .never))
    .background(content: { Color.gray })

    .getNestedSize({ [$height] in $height.wrappedValue = max($0.height, 1) }) // `1` creates a non-zero buffer before height calculates
    .frame(height: height)
    .padding()
})

#endif

#endif
