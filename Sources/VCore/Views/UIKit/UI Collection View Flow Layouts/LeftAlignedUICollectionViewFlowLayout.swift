//
//  LeftAlignedUICollectionViewFlowLayout.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Left Aligned UI Collection View Flow Layout
/// Layout object that organizes items into a grid with a left alignment.
open class LeftAlignedUICollectionViewFlowLayout: UICollectionViewFlowLayout {
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard
            let layoutAttributes: [UICollectionViewLayoutAttributes] = super.layoutAttributesForElements(in: rect)
        else {
            return nil
        }
        
        var leftMargin: CGFloat = sectionInset.left
        var maxY: CGFloat = -1
        
        for layoutAttribute in layoutAttributes {
            guard layoutAttribute.representedElementCategory == .cell else { continue }
            
            if layoutAttribute.frame.origin.y >= maxY { leftMargin = sectionInset.left }
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.size.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        
        return layoutAttributes
    }
}

#endif

// MARK: - Preview
#if canImport(UIKit) && !os(watchOS)

import SwiftUI

struct LeftAlignedUICollectionViewFlowLayout_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }

    private struct ViewControllerRepresentable: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            CenterAlignedUICollectionViewFlowLayout_Previews.BaseViewController(
                layout: LeftAlignedUICollectionViewFlowLayout()
            )
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}

#endif
