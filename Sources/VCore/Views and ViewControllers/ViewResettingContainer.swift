//
//  ViewResettingContainer.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.02.23.
//

import Foundation
import SwiftUI

// MARK: - View Resetting Container
/// `View` that resets content on demand.
///
/// Cane be used to trigger reload on an app level.
/// `SwiftUI`'s equivalent of replacing `rootViewController` in `UIKit`
///
/// In the following example, you can scroll down, trigger a reset,
/// and see that app's content is completely reset:
///
///     @main struct SomeApp: App {
///         var body: some Scene {
///             WindowGroup(content: {
///                 ViewResettingContainer(content: {
///                     ContentView()
///                 })
///             })
///         }
///     }
///
///     struct ContentView: View {
///         @EnvironmentObject private var viewResetter: ViewResetter
///
///         var body: some View {
///             ScrollView(content: {
///                 Color.red
///                     .frame(height: UIScreen.main.bounds.height)
///
///                 Button(
///                     "Reset",
///                     action: { viewResetter.trigger() }
///                 )
///             })
///         }
///     }
///
@available(iOS 14.0, *)
@available(macOS 11.0, *)
@available(tvOS 14.0, *)
@available(watchOS 7.0, *)
public struct ViewResettingContainer<Content>: View where Content: View {
    // MARK: Properties
    @StateObject private var viewResetter: ViewResetter = .init()
    private let content: () -> Content
    
    // MARK: Initializers
    /// Initializers `ViewResettingContainer` with content.
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    // MARK: Body
    public var body: some View {
        Group(content: {
            if viewResetter.value.isMultiple(of: 2) {
                content()
            } else {
                content()
            }
        })
            .environmentObject(viewResetter)
    }
}

// MARK: - View Resetter
/// ViewModel placed inside the environment of `ViewResettingContainer`
/// to trigger view resets on demand.
///
/// For more info, refer to `ViewResettingContainer`.
@available(iOS 14.0, *)
@available(macOS 11.0, *)
@available(tvOS 14.0, *)
@available(watchOS 7.0, *)
public final class ViewResetter: ObservableObject {
    // MARK: Properties
    @Published fileprivate var value: Int = 0
    
    // MARK: Initializers
    fileprivate init() {}
    
    // MARK: Trigger
    /// Triggers reset inside `ViewResettingContainer`.
    public func trigger() {
        value += 1
    }
}
