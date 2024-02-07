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
@available(tvOS 16.0, *)@available(tvOS, unavailable) // No `DisclosureGroup`
@available(watchOS, unavailable) // No `DisclosureGroup`
@available(visionOS, unavailable) // Doesn't follow HIG
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
                case .internal: _isExpanded_internal
                case .external: _isExpanded_external
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
        .background(content: { uiModel.backgroundColor })
    }
    
    private var labelView: some View {
        label()
            .frame(maxWidth: .infinity)
            .getSize({ labelHeight = $0.height })
            .background(content: {
                uiModel.backgroundColor
                    .contentShape(Rectangle())
                    .onTapGesture(perform: expandCollapseFromLabelTap)
            })
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
#if DEBUG

#if !(os(tvOS) || os(watchOS) || os(visionOS))

#Preview(body: {
    struct ContentView: View {
        @State private var isExpanded: Bool = true

        var body: some View {
            ZStack(content: {
#if os(iOS)
                Color(uiColor: .secondarySystemBackground).ignoresSafeArea()
#elseif os(macOS)
                Color.clear
#endif

                PlainDisclosureGroup(
                    isExpanded: $isExpanded,
                    label: {
                        Text("Lorem Ipsum")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .allowsHitTesting(false)
                    },
                    content: {
                        Color.accentColor
                            .frame(height: 300)
                    }
                )
                .applyModifier({
#if os(macOS)
                    $0.frame(dimension: 480)
#else
                    $0
#endif
                })
                .padding()
            })
        }
    }

    return ContentView()
})

#endif

#endif
