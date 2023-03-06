//
//  HOrVStack.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.03.23.
//

import SwiftUI

// MARK: - H or V Stack
/// `View` that arranges its subviews in a horizontal or vertical line.
public struct HOrVStack<Content>: View where Content: View {
    // MARK: Properties
    private let alignmentHor: HorizontalAlignment
    private let alignmentVer: VerticalAlignment
    private let spacing: CGFloat?
    private let isHorizontal: Bool
    private let content: () -> Content
    
    // MARK: Initializers
    /// Initializes `HOrVStack` with `Bool` and content.
    public init(
        alignmentHor: HorizontalAlignment = .center,
        alignmentVer: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        isHorizontal: Bool,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignmentHor = alignmentHor
        self.alignmentVer = alignmentVer
        self.spacing = spacing
        self.isHorizontal = isHorizontal
        self.content = content
    }
    
    /// Initializes `HOrVStack` with `Axis` and content.
    public init(
        alignmentHor: HorizontalAlignment = .center,
        alignmentVer: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        axis: Axis,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignmentHor = alignmentHor
        self.alignmentVer = alignmentVer
        self.spacing = spacing
        self.isHorizontal = {
            switch axis {
            case .horizontal: return true
            case .vertical: return false
            }
        }()
        self.content = content
    }
    
    // MARK: Body
    public var body: some View {
        if isHorizontal {
            HStack(
                alignment: alignmentVer,
                spacing: spacing,
                content: content
            )
            
        } else {
            VStack(
                alignment: alignmentHor,
                spacing: spacing,
                content: content
            )
        }
    }
}

// MARK: - Preview
@available(macOS 11.0, *)
struct HOrVStack_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20, content: {
            HOrVStack(
                spacing: 10,
                axis: .horizontal,
                content: {
                    Image(systemName: "swift")
                    Text("Lorem ipsum")
                }
            )
            
            Divider()
            
            HOrVStack(
                spacing: 10,
                axis: .vertical,
                content: {
                    Image(systemName: "swift")
                    Text("Lorem ipsum")
                }
            )
        })
            .padding()
    }
}
