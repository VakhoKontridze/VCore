//
//  AlignedGridView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.02.23.
//

import SwiftUI

// MARK: - Aligned Grid View
/// Vertical container that justifies collection of views with an alignment.
///
///     private let strings: [String] = [
///         "Monday", "Tuesday", "Wednesday",
///         "Thursday", "Friday", "Saturday",
///         "Sunday"
///     ]
///
///     var body: some View {
///         AlignedGridView(alignment: .center, spacing: 5).callAsFunction({
///             ForEach(strings, id: \.self, content: { string in
///                 Text(string)
///                     .background(content: { Color.accentColor.opacity(0.5) })
///             })
///         })
///         .padding()
///     }
///
/// `AlignedGridView` also supports `VStack`/`HStack`.
/// `AlignedGridView` wraps content, so they can be placed in any stacked layout.
/// If content declared above is moved to `gridView(alignment:)` method, then they can be stacked.
///
///     var body: some View {
///         VStack(content: {
///             gridView(alignment: .leading)
///             Divider()
///             gridView(alignment: .center)
///             Divider()
///             gridView(alignment: .trailing)
///         })
///     }
///
/// `AlignedGridView` also supports vertical `ScrollView` + `VStack`/`HStack`.
/// Layout will not break, since width can be calculated from the parent container, and height will wrap.
///
///     var body: some View {
///         ScrollView(content: {
///             VStack(content: {
///                 gridView(alignment: .leading)
///                 Divider()
///                 gridView(alignment: .center)
///                 Divider()
///                 gridView(alignment: .trailing)
///             })
///         })
///     }
///
/// `AlignedGridView` also supports horizontal `ScrollView` + `VStack`/`HStack`.
/// Without specifying an explicit width, layout will break, since width cannot be calculated from the parent container.
///
///     var body: some View {
///         ScrollView(.horizontal, content: {
///             HStack(content: {
///                 gridView(alignment: .leading).frame(width: 300)
///                 Divider()
///                 gridView(alignment: .center).frame(width: 300)
///                 Divider()
///                 gridView(alignment: .trailing).frame(width: 300)
///             })
///         })
///     }
///
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public struct AlignedGridView: Layout {
    // MARK: Properties
    private let alignment: HorizontalAlignment
    private let spacingHor: CGFloat
    private let spacingVer: CGFloat
    
    // MARK: Initializers
    /// Initializes `AlignedGridView` with alignment and spacings.
    public init(
        alignment: HorizontalAlignment,
        spacingHor: CGFloat,
        spacingVer: CGFloat
    ) {
        self.alignment = alignment
        self.spacingHor = spacingHor
        self.spacingVer = spacingVer
    }
    
    /// Initializes `AlignedGridView` with alignment and spacing.
    public init(
        alignment: HorizontalAlignment,
        spacing: CGFloat
    ) {
        self.init(
            alignment: alignment,
            spacingHor: spacing,
            spacingVer: spacing
        )
    }
    
    // MARK: Layout
    public func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let width: CGFloat = proposal.width ?? 0
        
        let rects: [CGRect] = calculateRects(
            boundOrigin: .zero,
            boundWidth: width,
            subviews: subviews
        )
        
        let height: CGFloat = rects.last?.maxY ?? 0
        
        return CGSize(width: width, height: height)
    }
    
    public func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let rects: [CGRect] = calculateRects(
            boundOrigin: bounds.origin,
            boundWidth: bounds.size.width,
            subviews: subviews
        )
        
        for (i, rect) in rects.enumerated() {
            subviews[i].place(
                at: rect.origin,
                proposal: ProposedViewSize(rect.size)
            )
        }
    }
    
    // MARK: Helpers
    private func calculateRects(
        boundOrigin: CGPoint,
        boundWidth: CGFloat,
        subviews: Subviews
    ) -> [CGRect] {
        let rects: [CGRect] = calculateLeadingRects(
            boundOrigin: boundOrigin,
            boundWidth: boundWidth,
            subviews: subviews
        )
        
        var sameRowRects: [[CGRect]] = rects.grouped(by: \.origin.y)
        
        let remainingRowSpacings: [CGFloat] = sameRowRects.map { group in
            let subviewWidths: CGFloat = group.map { $0.width }.reduce(0, +)
            let spacingWidths: CGFloat = CGFloat(group.count-1) * spacingHor
            return boundWidth - subviewWidths - spacingWidths
        }
        
        for i in sameRowRects.indices {
            for j in sameRowRects[i].indices {
                sameRowRects[i][j].origin.moveRight(withValue: {
                    switch alignment {
                    case .leading: 0
                    case .center: remainingRowSpacings[i]/2
                    case .trailing: remainingRowSpacings[i]
                    default: fatalError()
                    }
                }())
            }
        }
        
        return sameRowRects.flatMap { $0 }
    }
    
    private func calculateLeadingRects(
        boundOrigin: CGPoint,
        boundWidth: CGFloat,
        subviews: Subviews
    ) -> [CGRect] {
        var rects: [CGRect] = []
        
        var origin: CGPoint = boundOrigin
        
        for subview in subviews {
            let size: CGSize = subview.sizeThatFits(.unspecified)
            
            let clips: Bool = origin.x + spacingHor + size.width > boundOrigin.x + boundWidth
            if clips {
                origin.x = boundOrigin.x
                origin.moveDown(withValue: size.height + spacingVer)
            }
            
            rects.append(CGRect(origin: origin, size: size))
            
            origin.moveRight(withValue: spacingHor + size.width)
        }
        
        return rects
    }
}

// MARK: - Preview
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
struct AlignedGridView_Previews: PreviewProvider {
    // Previews
    static var previews: some View {
        Group(content: {
            VStackPreview().previewDisplayName("Vertical")
            HStackPreview().previewDisplayName("Horizontal")
            VScrollViewAndVStackPreview().previewDisplayName("Vertical Scroll + Vertical")
            VScrollViewAndHStackPreview().previewDisplayName("Vertical Scroll + Horizontal")
            HScrollViewAndHStackPreview().previewDisplayName("Horizontal Scroll + Horizontal")
        })
    }

    // Data
    private static var strings: [String] {
        [
            "January", "February", "March",
            "April", "May", "June",
            "July", "August", "September",
            "October", "November", "December"
        ]
    }

    // Previews (Scenes)
    private struct VStackPreview: View {
        var body: some View {
            VStack(content: {
                gridView(.leading)
                Divider()
                gridView(.center)
                Divider()
                gridView(.trailing)
            })
        }
    }

    private struct HStackPreview: View {
        var body: some View {
            HStack(content: {
                gridView(.leading)
                Divider()
                gridView(.trailing)
            })
        }
    }

    private struct VScrollViewAndVStackPreview: View {
        var body: some View {
            ScrollView(content: {
                VStack(content: {
                    gridView(.leading)
                    Divider()
                    gridView(.center)
                    Divider()
                    gridView(.trailing)
                })
            })
        }
    }

    private struct VScrollViewAndHStackPreview: View {
        var body: some View {
            ScrollView(content: {
                ScrollView(content: {
                    HStack(content: {
                        gridView(.leading)
                        Divider()
                        gridView(.trailing)
                    })
                })
            })
        }
    }

    private struct HScrollViewAndHStackPreview: View {
        var body: some View {
            ScrollView(.horizontal, content: {
                HStack(content: {
                    gridView(.leading).frame(width: 300)
                    Divider()
                    gridView(.center).frame(width: 300)
                    Divider()
                    gridView(.trailing).frame(width: 300)
                })
            })
        }
    }

    // Previews (Helpers)
    @ViewBuilder private static func gridView(
        _ alignment: HorizontalAlignment
    ) -> some View {
        AlignedGridView(alignment: alignment, spacing: 5).callAsFunction({
            ForEach(strings, id: \.self, content: { string in
                Text(string)
                    .padding(3)
                    .background(content: { Color.accentColor.opacity(0.5) })
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            })
        })
        .padding()
    }
}
