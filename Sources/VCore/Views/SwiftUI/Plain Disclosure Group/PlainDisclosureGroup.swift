//
//  PlainDisclosureGroup.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.06.22.
//

import SwiftUI

// MARK: - Plain Disclosure Group
/// Plain expandable container component that draws a background, and hosts content.
///
///     @State private var isExpanded: Bool = true
///
///     var body: some View {
///         PlainDisclosureGroup(
///             isExpanded: $isExpanded,
///             label: {
///                 Text("Lorem Ipsum")
///                     .allowsHitTesting(false)
///             },
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
///         .padding()
///     }
///
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS 16.0, *)@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct PlainDisclosureGroup<Label, Content>: View
    where
        Label: View,
        Content: View
{
    // MARK: Properties
    private let uiModel: PlainDisclosureGroupUIModel
    
    @State private var _isExpanded_internal: Bool
    @Binding private var _isExpanded_external: Bool
    private let stateManagement: StateManagement
    private var isExpanded: Binding<Bool> {
        .init(
            get: {
                switch stateManagement {
                case .internal: return _isExpanded_internal
                case .external: return _isExpanded_external
                }
            },
            set: { value in
                switch stateManagement {
                case .internal: _isExpanded_internal = value
                case .external: _isExpanded_external = value
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
        self.__isExpanded_internal = State(initialValue: false)
        self.__isExpanded_external = .constant(false) // Doesn't matter
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
        self.__isExpanded_internal = State(initialValue: false) // Doesn't matter
        self.__isExpanded_external = isExpanded
        self.stateManagement = .external
        self.label = label
        self.content = content
    }
    
    // MARK: Body
    public var body: some View {
        ZStack(alignment: .top, content: {
            DisclosureGroup(
                isExpanded: Binding(
                    get: { isExpanded.wrappedValue },
                    set: expandCollapseFromInternalAction
                ),
                content: content,
                label: { Spacer().frame(height: max(0, labelHeight - uiModel.defaultDisclosureGroupPadding)) }
            )
            .animation(.default, value: isExpanded.wrappedValue)
            
            labelView
        })
            .background(uiModel.backgroundColor)
    }
    
    private var labelView: some View {
        label()
            .frame(maxWidth: .infinity)
            .getSize({ labelHeight = $0.height })
            .background(
                uiModel.backgroundColor
                    .contentShape(Rectangle())
                    .onTapGesture(perform: expandCollapseFromLabelTap)
            )
    }
    
    // MARK: Actions
    private func expandCollapseFromInternalAction(newValue: Bool) {
        withAnimation(uiModel.expandCollapseAnimation, { isExpanded.wrappedValue = newValue })
    }
    
    private func expandCollapseFromLabelTap() {
        withAnimation(uiModel.expandCollapseAnimation, { isExpanded.wrappedValue.toggle() })
    }
    
    // MARK: State Management
    private enum StateManagement {
        case `internal`
        case external
    }
}

// MARK: - Preview
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS 14.0, *)@available(tvOS, unavailable)
@available(watchOS 7.0, *)@available(watchOS, unavailable)
struct PlainDisclosureGroup_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    private struct Preview: View {
        @State private var isExpanded: Bool = true
        
        var body: some View {
            PlainDisclosureGroup(
                isExpanded: $isExpanded,
                label: {
                    ZStack(content: {
                        Color.red.frame(height: 300)
                        Text("Lorem Ipsum")
                    })
                    .allowsHitTesting(false)
                },
                content: {
                    Color.accentColor
                        .frame(height: 300)
                }
            )
            .applyModifier({
#if os(macOS)
                $0.frame(dimension: 640)
#else
                $0
#endif
            })
            .padding()
        }
    }
}
