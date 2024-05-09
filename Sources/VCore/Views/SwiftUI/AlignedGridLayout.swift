//
//  AlignedGridLayout.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.02.23.
//

import SwiftUI

// MARK: - Aligned Grid Layout
/// Vertical container that justifies collection of views with an alignment.
///
///     private let strings: [String] = [
///         "Monday", "Tuesday", "Wednesday",
///         "Thursday", "Friday", "Saturday",
///         "Sunday"
///     ]
///
///     var body: some View {
///         AlignedGridLayout(horizontalAlignment: .center, spacing: 5).callAsFunction({
///             ForEach(strings, id: \.self, content: { string in
///                 Text(string)
///                     .background(content: { Color.accentColor.opacity(0.5) })
///             })
///         })
///         .padding()
///     }
///
/// `AlignedGridLayout` also supports `VStack`/`HStack`.
/// `AlignedGridLayout` wraps content, so they can be placed in any stacked layout.
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
/// `AlignedGridLayout` also supports vertical `ScrollView` + `VStack`/`HStack`.
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
/// `AlignedGridLayout` also supports horizontal `ScrollView` + `VStack`/`HStack`.
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
public struct AlignedGridLayout: Layout {
    // MARK: Properties
    private let horizontalAlignment: HorizontalAlignment
    private let verticalAlignment: VerticalAlignment

    private let spacingHorizontal: CGFloat
    private let spacingVertical: CGFloat
    
    // MARK: Initializers
    /// Initializes `AlignedGridLayout` with alignment and spacings.
    public init(
        horizontalAlignment: HorizontalAlignment,
        verticalAlignment: VerticalAlignment = .center,
        spacingHorizontal: CGFloat,
        spacingVertical: CGFloat
    ) {
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.spacingHorizontal = spacingHorizontal
        self.spacingVertical = spacingVertical
    }
    
    /// Initializes `AlignedGridLayout` with alignment and spacing.
    public init(
        horizontalAlignment: HorizontalAlignment,
        verticalAlignment: VerticalAlignment = .center,
        spacing: CGFloat
    ) {
        self.init(
            horizontalAlignment: horizontalAlignment,
            verticalAlignment: verticalAlignment,
            spacingHorizontal: spacing,
            spacingVertical: spacing
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
        var rects: [[CGRect]] = [[]]

        // Positions subviews in a grid so that they fit horizontally.
        // If a row doesn't fit, it's moved to a new line.
        do {
            var gridRowIndex: Int = 0 // Current grid index
            var origin: CGPoint = boundOrigin // Current subview origin

            for subview in subviews {
                let size: CGSize = subview.sizeThatFits(.unspecified)

                let isOutOfBoundsHorizontally: Bool =
                    origin.x + spacingHorizontal + size.width >
                    boundOrigin.x + boundWidth

                if isOutOfBoundsHorizontally {
                    origin.x = boundOrigin.x

                    let biggestHeightInGridRow: CGFloat = {
                        var heights: [CGFloat] = rects[gridRowIndex].map { $0.size.height }
                        heights.append(size.height)
                        return heights.max()! // Force-unwrap
                    }()
                    origin.moveDown(withValue: biggestHeightInGridRow + spacingVertical)
                }

                let rect: CGRect = .init(
                    origin: origin,
                    size: size
                )

                if isOutOfBoundsHorizontally {
                    rects.append([rect])
                    gridRowIndex += 1
                } else {
                    rects[gridRowIndex].append(rect)
                }

                origin.moveRight(withValue: spacingHorizontal + size.width) // Prepares next row
            }
        }

        // Positions rows horizontally
        do {
            let remainingRowSpacings: [CGFloat] = rects.map { group in
                let subviewWidths: CGFloat = group.map { $0.width }.reduce(0, +)
                let spacingWidths: CGFloat = CGFloat(group.count-1) * spacingHorizontal
                return boundWidth - subviewWidths - spacingWidths
            }

            for i in rects.indices {
                for j in rects[i].indices {
                    let offset: CGFloat = {
                        switch horizontalAlignment {
                        case .leading: 0
                        case .center: remainingRowSpacings[i]/2
                        case .trailing: remainingRowSpacings[i]
                        default: fatalError()
                        }
                    }()

                    rects[i][j].origin.moveRight(withValue: offset)
                }
            }
        }

        // Positions rows vertically
        do {
            for i in rects.indices {
                guard
                    let maxHeight: CGFloat = rects[i].max(by: \.size.height)?.size.height
                else {
                    continue
                }

                for j in rects[i].indices {
                    let offset: CGFloat = {
                        switch verticalAlignment {
                        case .top: 0
                        case .center: (maxHeight - rects[i][j].size.height)/2
                        case .bottom: maxHeight - rects[i][j].size.height
                        default: fatalError()
                        }
                    }()

                    rects[i][j].origin.moveDown(withValue: offset)
                }
            }
        }

        return rects.flatMap { $0 }
    }
}

// MARK: - Preview
#if DEBUG

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
#Preview("VStack", body: {
    VStack(content: {
        Preview_Section(.leading)
        Divider()
        Preview_Section(.center)
        Divider()
        Preview_Section(.trailing)
    })
})

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
#Preview("HStack", body: {
    HStack(content: {
        Preview_Section(.leading)
        Divider()
        Preview_Section(.trailing)
    })
})

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
#Preview("Vertical Alignments", body: {
    VStack(content: {
        Preview_Section(.center, verticalAlignment: .top, hasDifferentHeights: true)
        Divider()
        Preview_Section(.center, verticalAlignment: .center, hasDifferentHeights: true)
        Divider()
        Preview_Section(.center, verticalAlignment: .bottom, hasDifferentHeights: true)
    })
})

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
#Preview("Vertical ScrollView & VStack", body: {
    ScrollView(content: {
        VStack(content: {
            Preview_Section(.leading)
            Divider()
            Preview_Section(.center)
            Divider()
            Preview_Section(.trailing)
        })
    })
})

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
#Preview("Vertical ScrollView & HStack", body: {
    ScrollView(content: {
        HStack(content: {
            Preview_Section(.leading)
            Divider()
            Preview_Section(.trailing)
        })
    })
})

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
#Preview("Horizontal ScrollView & HStack", body: {
    ScrollView(.horizontal, content: {
        HStack(content: {
            Preview_Section(.leading).frame(width: 300)
            Divider()
            Preview_Section(.center).frame(width: 300)
            Divider()
            Preview_Section(.trailing).frame(width: 300)
        })
    })
})

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
private struct Preview_Section: View {
    private let horizontalAlignment: HorizontalAlignment
    private let verticalAlignment: VerticalAlignment
    private let hasDifferentHeights: Bool

    private let data: [String] = [
        "January", "February", "March",
        "April", "May", "June",
        "July", "August", "September",
        "October", "November", "December"
    ]

    init(
        _ horizontalAlignment: HorizontalAlignment,
        verticalAlignment: VerticalAlignment = .center,
        hasDifferentHeights: Bool = false
    ) {
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.hasDifferentHeights = hasDifferentHeights
    }

    var body: some View {
        AlignedGridLayout(
            horizontalAlignment: horizontalAlignment,
            verticalAlignment: verticalAlignment,
            spacing: 5
        ).callAsFunction({
            ForEach(
                data.enumeratedArray(),
                id: \.element,
                content: { (i, string) in
                    Text(string)
                        .padding(3)
                        .padding(.vertical, hasDifferentHeights ? CGFloat(i % 3)*3 : 0)

                        .background(content: { Color.accentColor.opacity(0.5) })

                        .clipShape(.rect(cornerRadius: 5))
                }
            )
        })
        .padding()
    }
}

#endif
