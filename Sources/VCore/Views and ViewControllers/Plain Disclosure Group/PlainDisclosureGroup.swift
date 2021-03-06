//
//  PlainDisclosureGroup.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.06.22.
//

#if os(iOS)

import SwiftUI

// MARK: - Plain Disclosure Group
/// Plain expandable container component that draws a background, and hosts content.
///
/// UI Model can be passed as parameter.
///
///     var body: some View {
///         PlainDisclosureGroup(
///             isExpanded: $isExpanded,
///             label: { Text("Lorem Ipsum") },
///             content: {
///                 ScrollView(content: {
///                     LazyVStack(content: {
///                         ForEach(0..<10, content: { num in
///                             Text(String(num))
///                                 .frame(maxWidth: .infinity, alignment: .leading)
///                                 .padding(.vertical, 5)
///                         })
///                     })
///                 })
///             }
///         )
///             .padding()
///     }
///
@available(iOS 14.0, *)
public struct PlainDisclosureGroup<Label, Content>: View
    where
        Label: View,
        Content: View
{
    // MARK: Properties
    private let uiModel: PlainDisclosureGroupUIModel
    
    @State private var isExpandedInternally: Bool = false
    @Binding private var isExpandedExternally: Bool
    private let stateManagement: StateManagement
    private var isExpanded: Binding<Bool> {
        .init(
            get: {
                switch stateManagement {
                case .internal: return isExpandedInternally
                case .external: return isExpandedExternally
                }
            },
            set: { value in
                switch stateManagement {
                case .internal: isExpandedInternally = value
                case .external: isExpandedExternally = value
                }
            }
        )
    }
    
    private let label: () -> Label
    private let content: () -> Content
    
    @State private var labelHeight: CGFloat = 0
    
    // MARK: Initializers
    /// Initializes `PlainDisclosureGroup` with label and content.
    public init(
        uiModel: PlainDisclosureGroupUIModel = .init(),
        label: @escaping () -> Label,
        content: @escaping () -> Content
    ) {
        self.uiModel = uiModel
        self._isExpandedExternally = .constant(false)
        self.stateManagement = .internal
        self.label = label
        self.content = content
    }
    
    /// Initializes `PlainDisclosureGroup` with active state, label, and content.
    public init(
        uiModel: PlainDisclosureGroupUIModel = .init(),
        isExpanded: Binding<Bool>,
        label: @escaping () -> Label,
        content: @escaping () -> Content
    ) {
        self.uiModel = uiModel
        self._isExpandedExternally = isExpanded
        self.stateManagement = .external
        self.label = label
        self.content = content
    }
    
    // MARK: Body
    public var body: some View {
        ZStack(alignment: .top, content: {
            labelView
            
            DisclosureGroup(
                isExpanded: .init(
                    get: { isExpanded.wrappedValue },
                    set: expandCollapseFromInternalAction
                ),
                content: content,
                label: { Color.clear.frame(height: max(0, labelHeight - uiModel.layout.defaultDisclosureGroupPadding)) }
            )
                .animation(.default, value: isExpanded.wrappedValue)
                .buttonStyle(.plain).accentColor(.clear) // Hides chevron button
        })
    }
    
    private var labelView: some View {
        label()
            .frame(maxWidth: .infinity)
            .readSize(onChange: { labelHeight = $0.height })
            .background(
                uiModel.colors.background
                    .contentShape(Rectangle())
                    .onTapGesture(perform: expandCollapseFromLabelTap)
            )
    }
    
    // MARK: Actions
    private func expandCollapseFromInternalAction(newValue: Bool) {
        withAnimation(uiModel.animations.expandCollapse, { isExpanded.wrappedValue = newValue })
    }
    
    private func expandCollapseFromLabelTap() {
        withAnimation(uiModel.animations.expandCollapse, { isExpanded.wrappedValue.toggle() })
    }
    
    // MARK: State Management
    private enum StateManagement {
        case `internal`
        case external
    }
}

// MARK: - Preview
@available(iOS 14.0, *)
struct PlainDisclosureGroup_Previews: PreviewProvider {
    @State private static var isExpanded: Bool = true
    
    static var previews: some View {
        PlainDisclosureGroup(
            isExpanded: $isExpanded,
            label: { Text("Lorem Ipsum") },
            content: {
                ScrollView(content: {
                    LazyVStack(content: {
                        ForEach(0..<10, content: { num in
                            Text(String(num))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 5)
                        })
                    })
                })
            }
        )
            .padding()
    }
}

#endif
