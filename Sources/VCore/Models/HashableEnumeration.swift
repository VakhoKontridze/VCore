//
//  HashableEnumeration.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import Foundation

// MARK: - Hashable Enumeration
/// Represents a generic hashable enumeration that can be used to abstract a selection in UI components,
/// independent of indexes.
///
///     enum DataSource: HashableEnumeration {
///         case red
///         case green
///         case blue
///     }
///
///     struct SomeCustomPicker<Data, Content>: View
///         where
///             Data: RandomAccessCollection,
///             Data.Index == Int,
///             Content: View
///     {
///         private let data: Data
///         private let content: (Data.Element) -> Content
///         @Binding private var selectedIndex: Int
///
///         init<T>(
///             selection: Binding<T>,
///             @ViewBuilder content: @escaping (Data.Element) -> Content
///         )
///             where
///                 Data == Array<T>,
///                 T: HashableEnumeration
///         {
///             self.data = Array(T.allCases)
///             self.content = content
///             self._selectedIndex = Binding(
///                 get: { Array(T.allCases).firstIndex(of: selection.wrappedValue)! },
///                 set: { selection.wrappedValue = Array(T.allCases)[$0] }
///             )
///         }
///
///         var body: some View {
///             Picker("", selection: $selectedIndex, content: {
///                 ForEach(data.indices, id: \.self, content: { i in
///                     content(data[i])
///                 })
///             })
///                 .pickerStyle(.segmented)
///         }
///     }
///
///     struct ContentView: View {
///         @State var selection: DataSource = .red
///
///         var body: some View {
///             SomeCustomPicker(selection: $selection, content: {
///                 Text(String(describing: $0).capitalized)
///             })
///         }
///     }
///
public protocol HashableEnumeration: Hashable, CaseIterable {}

// MARK: - String Representable Hashable Enumeration
/// Represents a titled generic hashable enumeration that can be used to abstract a selection in UI components,
/// independent of indexes.
///
/// Extending the example from `HashableEnumeration`,
/// we can make `DataSource` conform to `StringRepresentableHashableEnumeration`,
/// and modify API to following:
///
///     enum DataSource: StringRepresentableHashableEnumeration {
///         case red
///         case green
///         case blue
///
///         var stringRepresentation: String {
///             String(describing: self).capitalized
///         }
///     }
///
///     struct SomeCustomPicker<...>: ... {
///         ...
///
///         init<T>(
///             selection: Binding<T>
///         )
///             where
///                 Data == Array<T>,
///                 Content == Text,
///                 T: StringRepresentableHashableEnumeration
///         {
///             self.content = { Text($0.stringRepresentation) }
///             ...
///         }
///
///         ...
///     }
///
///     struct ContentView: View {
///         @State var selection: DataSource = .red
///
///         var body: some View {
///             SomeCustomPicker(selection: $selection)
///         }
///     }
///
public protocol StringRepresentableHashableEnumeration: HashableEnumeration {
    /// `String` representation.
    var stringRepresentation: String { get }
}
