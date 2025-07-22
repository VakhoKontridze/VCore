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
///         ZStack {
///             Color(uiColor: UIColor.secondarySystemBackground)
///                 .ignoresSafeArea()
///
///             PlainDisclosureGroup(
///                 isExpanded: $isExpanded,
///                 label: {
///                     Text("Lorem Ipsum")
///                         .frame(maxWidth: .infinity)
///                         .padding(5)
///                         .allowsHitTesting(false)
///                 },
///                 content: {
///                     ScrollView {
///                         LazyVStack {
///                             ForEach(0..<10) { num in
///                                 Text(String(num))
///                                     .frame(maxWidth: .infinity, alignment: .leading)
///                                     .padding(.vertical, 5)
///                             }
///                         }
///                     }
///                 }
///             )
///             .padding()
///         }
///     }
///
@available(tvOS, unavailable) // No `DisclosureGroup`
@available(watchOS, unavailable) // No `DisclosureGroup`
@available(visionOS, unavailable) // Doesn't follow HIG
public struct PlainDisclosureGroup<Label, Content>: View
    where
        Label: View,
        Content: View
{
    // MARK: Properties - Appearance
    private let appearance: PlainDisclosureGroupAppearance
    
    @State private var labelHeight: CGFloat = 0

    private var nativeLabelHeight: CGFloat {
        let target: CGFloat = labelHeight - appearance.systemDisclosureGroupPadding
        let system: CGFloat = appearance.systemDisclosureGroupContentHeight

        return max(target, system)
    }

    private var nativeLabelMaskHeight: CGFloat {
        nativeLabelHeight + appearance.systemDisclosureGroupPadding
    }
    
    // MARK: Properties - State
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
    
    // MARK: Properties - Label and Content
    private let label: () -> Label
    private let content: () -> Content

    // MARK: Initializers
    /// Initializes `PlainDisclosureGroup` with label and content.
    public init(
        appearance: PlainDisclosureGroupAppearance = .init(),
        label: @escaping () -> Label,
        content: @escaping () -> Content
    ) {
        self.appearance = appearance
        self.__isExpanded_internal = State(wrappedValue: false)
        self.__isExpanded_external = .constant(false) // Doesn't matter
        self.stateManagement = .internal
        self.label = label
        self.content = content
    }
    
    /// Initializes `PlainDisclosureGroup` with active state, label, and content.
    public init(
        appearance: PlainDisclosureGroupAppearance = .init(),
        isExpanded: Binding<Bool>,
        label: @escaping () -> Label,
        content: @escaping () -> Content
    ) {
        self.appearance = appearance
        self.__isExpanded_internal = State(wrappedValue: false) // Doesn't matter
        self.__isExpanded_external = isExpanded
        self.stateManagement = .external
        self.label = label
        self.content = content
    }
    
    // MARK: Body
    public var body: some View {
        ZStack(alignment: .top) {
            DisclosureGroup(
                isExpanded: Binding(
                    get: { isExpanded.wrappedValue },
                    set: { expandCollapseFromInternalAction(newValue: $0) }
                ),
                content: content,
                label: { Spacer().frame(height: nativeLabelHeight) }
            )
            .mask { nativeLabelViewMask }
            .animation(.default, value: isExpanded.wrappedValue)
            
            labelView
        }
        .background(appearance.backgroundColor)
    }
    
    private var labelView: some View {
        label()
            .frame(maxWidth: .infinity)
            .onGeometryChange(of: { $0.size.height }) { labelHeight = $0 }
            .background {
                Color.clear
                    .contentShape(.rect)
                    .onTapGesture(perform: expandCollapseFromLabelTap)
            }
    }

    private var nativeLabelViewMask: some View {
        VStack(spacing: 0) {
            Color.clear.frame(height: nativeLabelMaskHeight)
            Color.black
        }
    }

    // MARK: Actions
    private func expandCollapseFromInternalAction(newValue: Bool) {
        withAnimation(appearance.expandCollapseAnimation) {
            isExpanded.wrappedValue = newValue
        }
    }
    
    private func expandCollapseFromLabelTap() {
        withAnimation(appearance.expandCollapseAnimation) {
            isExpanded.wrappedValue.toggle()
        }
    }
    
    // MARK: State Management
    private enum StateManagement {
        case `internal`
        case external
    }
}

// MARK: - Preview
#if DEBUG

#if !(os(tvOS) || os(watchOS) || os(visionOS)) // Redundant

#Preview {
    @Previewable @State var isExpanded: Bool = true
    
    let backgroundView: some View = {
#if os(iOS)
        Color(uiColor: UIColor.secondarySystemBackground)
            .ignoresSafeArea()
#elseif os(macOS)
        Color.clear
#else
        fatalError() // Not supported
#endif
    }()

    ZStack {
        backgroundView

        PlainDisclosureGroup(
            isExpanded: $isExpanded,
            label: {
                Text("Lorem Ipsum")
                    .frame(maxWidth: .infinity)
                    .padding(5)
                    .allowsHitTesting(false)
            },
            content: {
                Color.accentColor
                    .frame(height: 300)
            }
        )
#if os(macOS)
        .frame(dimension: 480)
#endif
        .padding()
    }
}

#endif

#endif
