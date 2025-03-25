//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import SwiftUI

// MARK: - Clamped
@available(*, deprecated, message: "Will be removed in '8.0'")
@propertyWrapper
public struct Clamped<Value>: DynamicProperty, Sendable
    where Value: Sendable
{
    @State private var storage: Value

    public var wrappedValue: Value {
        get { storage }
        nonmutating set { storage = transformation(newValue) }
    }
    
    public var projectedValue: Binding<Value> {
        .init(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    
    private let transformation: @Sendable (Value) -> Value
    
    fileprivate init(
        wrappedValue: Value,
        transformation: @escaping @Sendable (Value) -> Value
    ) {
        self._storage = State(wrappedValue: wrappedValue)
        self.transformation = transformation
    }

    public init(
        wrappedValue: Value,
        _ range: ClosedRange<Value>,
        step: Value? = nil
    )
        where Value: BinaryInteger
    {
        self.init(
            wrappedValue: wrappedValue,
            transformation: { $0.clamped(to: range, step: step) }
        )
    }

    public init(
        wrappedValue: Value,
        _ range: ClosedRange<Value>,
        step: Value? = nil
    )
        where Value: FloatingPoint
    {
        self.init(
            wrappedValue: wrappedValue,
            transformation: { $0.clamped(to: range, step: step) }
        )
    }
}

// MARK: - Old Value Cache
@available(*, deprecated, message: "Will be removed in '8.0'")
@propertyWrapper
public struct OldValueCache<Value>: DynamicProperty, Sendable
    where Value: Sendable
{
    @State private var storage: Value
    @State private var storageOld: Value?
    
    public var wrappedValue: Value {
        get {
            storage
        }
        nonmutating set {
            storageOld = storage
            storage = newValue
        }
    }

    public var projectedValue: Binding<Value> {
        .init(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    
    public var wrappedValueOld: Value? {
        get { storageOld }
        nonmutating set { storageOld = newValue }
    }
    
    public init(wrappedValue: Value) {
        self._storage = State(wrappedValue: wrappedValue)
        self._storageOld = State(wrappedValue: nil)
    }
}

// MARK: - Localization Manager
extension LocalizationManager {
    @available(*, deprecated, message: "Use 'static' property instead")
    public var locales: [Locale] {
        Self.locales
    }
}

// MARK: - Extensions - Foundation
extension StringProtocol {
    @available(*, deprecated, renamed: "contains(any:)")
    public func contains(_ characterSets: [CharacterSet]) -> Bool {
        contains(characterSets.unified)
    }
}

// MARK: - Extensions - Swift UI

extension View {
    @available(*, deprecated, message: "Use 'getSize(_:)' instead")
    public func getSize(
        assignTo binding: Binding<CGSize>
    ) -> some View {
        self
            .getSize({ binding.wrappedValue = $0 })
    }
    
    @available(*, deprecated, message: "Use 'getSize(_:)' instead")
    public func getWidth(
        assignTo binding: Binding<CGFloat>
    ) -> some View {
        self
            .getSize({ binding.wrappedValue = $0.width })
    }
    
    @available(*, deprecated, message: "Use 'getSize(_:)' instead")
    public func getHeight(
        assignTo binding: Binding<CGFloat>
    ) -> some View {
        self
            .getSize({ binding.wrappedValue = $0.height })
    }
}

extension View {
    @available(*, deprecated, message: "Use 'getBounds(of:_:)' instead")
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
    public func getBounds(
        of coordinateSpace: NamedCoordinateSpace,
        assignTo binding: Binding<CGRect?>
    ) -> some View {
        self
            .getBounds(
                of: coordinateSpace,
                { binding.wrappedValue = $0 }
            )
    }
}

extension View {
    @available(*, deprecated, message: "Use 'getFrame(in:_:)' instead")
    public func getFrame(
        in coordinateSpace: CoordinateSpace,
        assignTo binding: Binding<CGRect>
    ) -> some View {
        self
            .getFrame(
                in: coordinateSpace,
                { binding.wrappedValue = $0 }
            )
    }
    
    @available(*, deprecated, message: "Use 'getFrame(in:_:)' instead")
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
    public func getFrame(
        in coordinateSpace: some CoordinateSpaceProtocol,
        assignTo binding: Binding<CGRect>
    ) -> some View {
        self
            .getFrame(
                in: coordinateSpace,
                { binding.wrappedValue = $0 }
            )
    }
}

extension View {
    @available(*, deprecated, message: "Use 'getSafeAreaInsets(ignoredKeyboardSafeAreaEdges:_:)' instead")
    public func getSafeAreaInsets(
        ignoredKeyboardSafeAreaEdges: Edge.Set = [],
        assignTo binding: Binding<EdgeInsets>
    ) -> some View {
        self
            .getSafeAreaInsets(
                ignoredKeyboardSafeAreaEdges: ignoredKeyboardSafeAreaEdges,
                { binding.wrappedValue = $0 }
            )
    }
}

// MARK: - Extensions - UI Kit
#if canImport(UIKit) && !targetEnvironment(macCatalyst)

import UIKit

extension UIColor {
    @available(*, deprecated, message: "Use 'mix(with:by)' instead")
    public static func blend(
        _ color1: UIColor,
        ratio1: CGFloat = 0.5,
        with color2: UIColor,
        ratio2: CGFloat = 0.5
    ) -> UIColor {
        color1.mix(with: color2, by: ratio1/(ratio1 + ratio2))
    }
}

#endif

#if canImport(UIKit) && !os(watchOS)

import UIKit

extension UIApplication {
    @available(*, deprecated, renamed: "topmostViewController")
    public func topMostViewController(
        inWindow window: UIWindow
    ) -> UIViewController? {
        topmostViewController(inWindow: window)
    }
}

#endif

// MARK: - Extensions - App Kit
#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit

extension NSColor {
    @available(*, deprecated, message: "Use 'mix(with:by)' instead")
    public static func blend(
        _ color1: NSColor,
        ratio1: CGFloat = 0.5,
        with color2: NSColor,
        ratio2: CGFloat = 0.5
    ) -> NSColor {
        color1.mix(with: color2, by: ratio1/(ratio1 + ratio2))
    }
}

#endif
