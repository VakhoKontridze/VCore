//
//  View.BindValueToModalContext.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.05.22.
//

import SwiftUI

// MARK: - View Bind Value to Modal Context
@available(iOS 14.0, *)
@available(macOS 11.0, *)
@available(tvOS 14.0, *)
@available(watchOS 7.0, *)
extension View {
    /// Binds value to modal context by applying an empty `onChange` modifier to the value.
    ///
    /// Can be used to avoid using `Binding` modifiers when presenting modals.
    ///
    /// Issue:
    ///
    ///     @State private var isOn: Bool = false
    ///     @State private var isPresented: Bool = false
    ///
    ///     var body: some View {
    ///         VStack(content: {
    ///             Button("Present", action: { isPresented = true })
    ///
    ///             Toggle("Lorem Ipsum", isOn: $isOn)
    ///         })
    ///             .padding()
    ///             .sheet(isPresented: $isPresented, content: {
    ///                 Text(String(isOn)) // Displays "false"
    ///             })
    ///     }
    ///
    /// One solution lies in using `.sheet(item:content:)` to bind value to modal:
    ///
    ///     private struct Sheet: Identifiable {
    ///         let id: UUID = .init()
    ///         let isOn: Bool
    ///     }
    ///
    ///     @State private var presentedSheet: Sheet?
    ///     @State private var isOn: Bool = false
    ///
    ///     var body: some View {
    ///         VStack(content: {
    ///             Button("Present", action: { presentedSheet = .init(isOn: isOn) })
    ///
    ///             Toggle("Lorem Ipsum", isOn: $isOn)
    ///         })
    ///             .padding()
    ///             .sheet(item: $presentedSheet, content: { sheet in
    ///                 Text(String(sheet.isOn)) // Displays "true"
    ///             })
    ///     }
    ///
    /// Non-`Binding` modal can still be bound using this method:
    ///
    ///     @State private var isOn: Bool = false
    ///     @State private var isPresented: Bool = false
    ///
    ///     var body: some View {
    ///         VStack(content: {
    ///             Button("Present", action: { isPresented = true })
    ///
    ///             Toggle("Lorem Ipsum", isOn: $isOn)
    ///         })
    ///             .padding()
    ///             .bindToModalContext(isOn)
    ///             .sheet(isPresented: $isPresented, content: {
    ///                 Text(String(isOn)) // Displays "true"
    ///             })
    ///     }
    public func bindToModalContext<V>(_ value: V) -> some View
        where V: Equatable
    {
        self
            .onChange(of: value, perform: { _ in })
    }
}
