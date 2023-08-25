//
//  CenterAlignedUICollectionViewFlowLayout.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Center Aligned UI Collection View Flow Layout
/// Layout object that organizes items into a grid with a center alignment.
///
/// Requires `UICollectionViewDelegateFlowLayout` to be set via `delegate`.
open class CenterAlignedUICollectionViewFlowLayout: UICollectionViewFlowLayout {
    // MARK: Properties
    private var itemLayoutAttributes: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    
    // MARK: Lifecycle
    public override func prepare() {
        super.prepare()
        
        itemLayoutAttributes = [:]
    }
    
    // MARK: Item Attributes
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView else { return nil }
        
        var updatedItemLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for i in 0..<collectionView.numberOfSections {
            for j in 0..<collectionView.numberOfItems(inSection: i) {
                let indexPath: IndexPath = .init(row: j, section: i)
                
                layoutAttributesForItem(at: indexPath).map {
                    guard $0.frame.intersects(rect) else { return }
                    updatedItemLayoutAttributes.append($0)
                }
                
                layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath).map {
                    updatedItemLayoutAttributes.append($0)
                }
                
                layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, at: indexPath).map {
                    updatedItemLayoutAttributes.append($0)
                }
            }
        }
        
        return updatedItemLayoutAttributes
    }
    
    // MARK: Item Attribute
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard
            let collectionView,
            let flowDelegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout
        else {
            return super.layoutAttributesForItem(at: indexPath)
        }
        
        if let attributes: UICollectionViewLayoutAttributes = itemLayoutAttributes[indexPath] { return attributes }
        
        let availableWidthForCells: CGFloat = // Available width left where cells can be centered
            collectionView.bounds.size.width -
            collectionView.contentInset.left -
            collectionView.contentInset.right
        
        let sameRowItemAttributes: [UICollectionViewLayoutAttributes] = findSameRowItemAttributes(
            collectionView: collectionView,
            indexPath: indexPath,
            availableWidthForCells: availableWidthForCells
        )
        
        let interitemSpacing: CGFloat = calculateRowItemInterimSpacing( // Minimum spacing between items in a row
            collectionView: collectionView,
            flowDelegate: flowDelegate,
            indexPath: indexPath,
            sameRowItemAttributes: sameRowItemAttributes
        )
        
        let centerAlignmentXOffset: CGFloat = calculateXOffset(
            availableWidthForCells: availableWidthForCells,
            interitemSpacing: interitemSpacing,
            sameRowItemAttributes: sameRowItemAttributes
        )
        
        // Adjusts x positions
        do {
            var previousFrame: CGRect = .zero
            
            for itemAttributes in sameRowItemAttributes {
                let centeredItemFrame: CGRect = {
                    var centeredItemFrame: CGRect = itemAttributes.frame
                    
                    centeredItemFrame.origin.x = {
                        switch previousFrame {
                        case .zero: return centerAlignmentXOffset
                        default: return previousFrame.maxX + interitemSpacing
                        }
                    }()
                    
                    return centeredItemFrame
                }()
                
                itemAttributes.frame = centeredItemFrame
                
                previousFrame = centeredItemFrame
                itemLayoutAttributes[itemAttributes.indexPath] = itemAttributes
            }
        }
        
        return itemLayoutAttributes[indexPath]
    }
    
    // MARK: Helpers
    private func findSameRowItemAttributes(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        availableWidthForCells: CGFloat
    ) -> [UICollectionViewLayoutAttributes] {
        var sameRowItemAttributes: [UICollectionViewLayoutAttributes] = .init()
        
        let defaultRowFrame: CGRect = { // Needed for finding items in row, by checking intersect
            var defaultRowFrame: CGRect = super.layoutAttributesForItem(at: indexPath)?.frame ?? .zero
            defaultRowFrame.origin.x = 0
            defaultRowFrame.size.width = availableWidthForCells
            return defaultRowFrame
        }()
        
        let indexOfFirstItemInRow: Int = { // Stop at 0, or when it reach previous row
            var index: Int = indexPath.row
            
            while true {
                let previousIndex = index - 1
                guard previousIndex >= 0 else { break }
                
                let previousIndexPath: IndexPath = .init(row: previousIndex, section: indexPath.section)
                let previousFrame: CGRect = super.layoutAttributesForItem(at: previousIndexPath)?.frame ?? .zero
                
                guard previousFrame.intersects(defaultRowFrame) else { break }
                
                index = previousIndex
            }
            
            return index
        }()
        
        do {
            var currentIndex = indexOfFirstItemInRow
            while true {
                guard currentIndex <= collectionView.numberOfItems(inSection: indexPath.section) - 1 else { break }
                
                let currentIndexPath: IndexPath = .init(row: currentIndex, section: indexPath.section)
                guard
                    let currentAttributes: UICollectionViewLayoutAttributes = super.layoutAttributesForItem(at: currentIndexPath),
                    currentAttributes.frame.intersects(defaultRowFrame),
                    let copyOfCurrentAttributes: UICollectionViewLayoutAttributes = currentAttributes.copy() as? UICollectionViewLayoutAttributes
                else {
                    break
                }
                
                sameRowItemAttributes.append(copyOfCurrentAttributes)
                currentIndex += 1
            }
        }
        
        return sameRowItemAttributes
    }
    
    private func calculateRowItemInterimSpacing(
        collectionView: UICollectionView,
        flowDelegate: UICollectionViewDelegateFlowLayout,
        indexPath: IndexPath,
        sameRowItemAttributes: [UICollectionViewLayoutAttributes]
    ) -> CGFloat {
        guard
            delegateSupportsInteritemSpacing(
                collectionView: collectionView,
                flowDelegate: flowDelegate
            ),
            sameRowItemAttributes.count > 0
        else {
            return minimumInteritemSpacing
        }
        
        return flowDelegate.collectionView?(
            collectionView,
            layout: self,
            minimumInteritemSpacingForSectionAt: indexPath.section
        ) ?? 0
    }
    
    private func calculateXOffset(
        availableWidthForCells: CGFloat,
        interitemSpacing: CGFloat,
        sameRowItemAttributes: [UICollectionViewLayoutAttributes]
    ) -> CGFloat {
        let sumOfInteritemSpacings: CGFloat = interitemSpacing * CGFloat(sameRowItemAttributes.count - 1)
        let sumOfItemWidths: CGFloat = sameRowItemAttributes.reduce(0, { $0 + $1.frame.size.width })
        let alignmentWidth: CGFloat = sumOfItemWidths + sumOfInteritemSpacings
        let centerAlignmentXOffset: CGFloat = (availableWidthForCells - alignmentWidth) / 2
        
        return centerAlignmentXOffset
    }
    
    private func delegateSupportsInteritemSpacing(
        collectionView: UICollectionView,
        flowDelegate: UICollectionViewDelegateFlowLayout
    ) -> Bool {
        flowDelegate.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:minimumInteritemSpacingForSectionAt:)))
    }
}

#endif

// MARK: - Preview
#if os(iOS)

import SwiftUI

struct CenterAlignedUICollectionViewFlowLayout_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }

    private struct ViewControllerRepresentable: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            BaseViewController(
                layout: CenterAlignedUICollectionViewFlowLayout()
            )
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }

    /*private*/ final class BaseViewController:
        UIViewController,
        UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
        UICollectionViewDataSource
    {
        private lazy var collectionView: UICollectionView = {
            do {
                layout.headerReferenceSize = CGSize(width: 0, height: 10)
                layout.footerReferenceSize = CGSize(width: 0, height: 10)

                layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

                layout.minimumLineSpacing = 10
                layout.minimumInteritemSpacing = 10

                layout.scrollDirection = .vertical
                layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
            }

            let collectionView: UICollectionView = .init(
                frame: .zero,
                collectionViewLayout: layout
            )

            collectionView.translatesAutoresizingMaskIntoConstraints = false

            collectionView.delegate = self
            collectionView.dataSource = self

            collectionView.register(
                SomeCollectionViewCell.self,
                forCellWithReuseIdentifier: SomeCollectionViewCell.dequeueID
            )

            collectionView.register(
                UICollectionReusableView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: String(describing: UICollectionReusableView.self)
            )
            collectionView.register(
                UICollectionReusableView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: String(describing: UICollectionReusableView.self)
            )

            return collectionView
        }()

        private let layout: UICollectionViewFlowLayout
        private var data: [UIColor] = [[UIColor]].init(repeating: [.red, .green, .blue], count: 10).flatMap { $0 }.shuffled()

        init(layout: UICollectionViewFlowLayout) {
            self.layout = layout
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError()
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            view.backgroundColor = .systemBackground

            view.addSubview(collectionView)
            NSLayoutConstraint.activate([
                collectionView.constraintLeading(to: view, constant: 20),
                collectionView.constraintTrailing(to: view, constant: -20),
                collectionView.constraintTop(to: view, layoutGuide: .safeArea, constant: 20),
                collectionView.constraintBottom(to: view, layoutGuide: .safeArea, constant: -20)
            ])

            collectionView.reloadData()
        }

        func numberOfSections(in collectionView: UICollectionView) -> Int {
            2
        }

        func collectionView(
            _ collectionView: UICollectionView,
            viewForSupplementaryElementOfKind kind: String,
            at indexPath: IndexPath
        ) -> UICollectionReusableView {
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let view: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: String(describing: UICollectionReusableView.self),
                    for: indexPath
                )

                view.frame = CGRect(
                    origin: view.frame.origin,
                    size: CGSize(width: collectionView.frame.size.width, height: 10)
                )
                view.backgroundColor = .red

                return view

            case UICollectionView.elementKindSectionFooter:
                let view: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: String(describing: UICollectionReusableView.self),
                    for: indexPath
                )

                view.frame = CGRect(
                    origin: view.frame.origin,
                    size: CGSize(width: collectionView.frame.size.width, height: 10)
                )
                view.backgroundColor = .blue

                return view

            default:
                fatalError()
            }
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            data.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SomeCollectionViewCell.dequeueID, for: indexPath)
                    as? SomeCollectionViewCell
            else {
                fatalError()
            }

            cell.configure(color: data[indexPath.row])

            return cell
        }
    }

    private final class SomeCollectionViewCell: UICollectionViewCell {
        private var widthConstraint: NSLayoutConstraint?

        static var dequeueID: String { .init(describing: self) }

        override init(frame: CGRect) {
            super.init(frame: frame)

            NSLayoutConstraint.activate([
                contentView.constraintWidth(to: nil, priority: .defaultLow)
                    .storing(in: &widthConstraint),
                contentView.constraintHeight(to: nil, constant: 32)
            ])
        }

        required init?(coder: NSCoder) {
            fatalError()
        }

        func configure(color: UIColor) {
            contentView.backgroundColor = color.withAlphaComponent(0.3)
            widthConstraint?.constant = .random(in: 20...100)
        }
    }
}

#endif
