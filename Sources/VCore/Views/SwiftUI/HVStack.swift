//
//  HVStack.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.03.23.
//

import SwiftUI

// MARK: - HVStack
/// `View` that arranges its subviews in a horizontal or vertical line.
public struct HVStack<Content>: View where Content: View { // TODO: iOS 16 - Remove, as it's obsoleted by `Layout`
    // MARK: Properties
    private let alignmentHorizontal: HorizontalAlignment
    private let alignmentVertical: VerticalAlignment
    private let spacing: CGFloat?
    private let isHorizontal: Bool
    private let content: () -> Content
    
    // MARK: Initializers
    /// Initializes `HVStack` with `Bool` and content.
    public init(
        alignmentHorizontal: HorizontalAlignment = .center,
        alignmentVertical: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        isHorizontal: Bool,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignmentHorizontal = alignmentHorizontal
        self.alignmentVertical = alignmentVertical
        self.spacing = spacing
        self.isHorizontal = isHorizontal
        self.content = content
    }
    
    /// Initializes `HVStack` with `Axis` and content.
    public init(
        alignmentHorizontal: HorizontalAlignment = .center,
        alignmentVertical: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        axis: Axis,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignmentHorizontal = alignmentHorizontal
        self.alignmentVertical = alignmentVertical
        self.spacing = spacing
        self.isHorizontal = {
            switch axis {
            case .horizontal: true
            case .vertical: false
            }
        }()
        self.content = content
    }
    
    // MARK: Body
    public var body: some View {
        if isHorizontal {
            HStack(
                alignment: alignmentVertical,
                spacing: spacing,
                content: content
            )
            
        } else {
            VStack(
                alignment: alignmentHorizontal,
                spacing: spacing,
                content: content
            )
        }
    }
}
