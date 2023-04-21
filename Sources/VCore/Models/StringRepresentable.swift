//
//  StringRepresentable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

import Foundation

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
///     struct SomeCustomPicker<SelectionValue, ID, Content>: View
///         where
///             SelectionValue: Hashable,
///             ID: Hashable,
///             Content: View
///     {
///         @Binding private var selection: SelectionValue
///         private let data: [SelectionValue]
///         private let id: KeyPath<SelectionValue, ID>
///         private let content: (SelectionValue) -> Content
///
///         init(
///             selection: Binding<SelectionValue>,
///             data: [SelectionValue],
///             id: KeyPath<SelectionValue, ID>,
///             @ViewBuilder content: @escaping (SelectionValue) -> Content
///         ) {
///             self._selection = selection
///             self.data = data
///             self.id = id
///             self.content = content
///         }
///
///         init(
///             selection: Binding<SelectionValue>,
///             data: [SelectionValue],
///             @ViewBuilder content: @escaping (SelectionValue) -> Content
///         )
///             where
///                 SelectionValue: Identifiable,
///                 ID == SelectionValue.ID
///         {
///             self._selection = selection
///             self.data = data
///             self.id = \.id
///             self.content = content
///         }
///
///         init(
///             selection: Binding<SelectionValue>
///         )
///             where
///                 SelectionValue: Identifiable & CaseIterable & StringRepresentable,
///                 ID == SelectionValue.ID,
///                 Content == Text
///         {
///             self._selection = selection
///             self.data = Array(SelectionValue.allCases)
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
