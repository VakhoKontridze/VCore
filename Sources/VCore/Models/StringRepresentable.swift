//
//  StringRepresentable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import SwiftUI

// MARK: - String Representable
/// Represents a titled type that can be used to abstract a selection in UI components.
///
///     enum RGBColor: Int, Hashable, Identifiable, CaseIterable, StringRepresentable {
///         case red, green, blue
///
///         var id: Int { rawValue }
///         var stringRepresentation: String { .init(describing: self).capitalized }
///     }
///
///     struct SomeCustomPicker<Data, ID, Content>: View
///         where
///             Data: RandomAccessCollection,
///             Data.Element: Hashable,
///             ID: Hashable,
///             Content: View
///     {
///         @Binding private var selection: Data.Element
///         private let data: [Data.Element]
///         private let id: KeyPath<Data.Element, ID>
///         private let content: (Data.Element) -> Content
///
///         init(
///             selection: Binding<Data.Element>,
///             data: Data,
///             id: KeyPath<Data.Element, ID>,
///             @ViewBuilder content: @escaping (Data.Element) -> Content
///         ) {
///             self._selection = selection
///             self.data = Array(data)
///             self.id = id
///             self.content = content
///         }
///
///         init(
///             selection: Binding<Data.Element>,
///             data: Data,
///             @ViewBuilder content: @escaping (Data.Element) -> Content
///         )
///             where
///                 Data.Element: Identifiable,
///                 ID == Data.Element.ID
///         {
///             self._selection = selection
///             self.data = Array(data)
///             self.id = \.id
///             self.content = content
///         }
///
///         init<T>(
///             selection: Binding<T>
///         )
///             where
///                 Data == Array<T>,
///                 T: Identifiable & CaseIterable & StringRepresentable,
///                 ID == T.ID,
///                 Content == Text
///         {
///             self._selection = selection
///             self.data = Array(T.allCases)
///             self.id = \.id
///             self.content = { Text($0.stringRepresentation) }
///         }
///
///         var body: some View {
///             Picker(
///                 selection: $selection,
///                 content: {
///                     ForEach(data, id: id, content: { element in
///                         content(element)
///                             .tag(element)
///                     })
///                 },
///                 label: EmptyView.init
///             )
///             .labelsHidden()
///             .pickerStyle(.segmented)
///         }
///     }
///
///     struct ContentView: View {
///         @State var selection: RGBColor = .red
///
///         var body: some View {
///             VStack(content: {
///                 SomeCustomPicker(
///                     selection: $selection,
///                     data: [.red, .green, .blue],
///                     id: \.rawValue,
///                     content: { Text(String(describing: $0).capitalized) }
///                 )
///
///                 SomeCustomPicker(
///                     selection: $selection,
///                     data: [.red, .green, .blue],
///                     content: { Text(String(describing: $0).capitalized) }
///                 )
///
///                 SomeCustomPicker(
///                     selection: $selection
///                 )
///             })
///             .padding()
///         }
///     }
///
public protocol StringRepresentable {
    /// `String` representation.
    var stringRepresentation: String { get }
}
