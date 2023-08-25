//
//  CarouselCollectionViewFlowLayout.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 18.08.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Carousel Collection View Flow Layout
/// Layout object that organizes items into a grid with a flowing carousel alignment.
///
/// Item size should be set via property `itemSize` property.
/// Alternately, `CarouselCollectionViewFlowLayoutItemSize` can be passed as parameter init init,
/// which only takes item `height`, and horizontal `inset`, and dynamically resizes the `UICollectionViewCell`.
///
/// Spacing can be set via `minimumLineSpacing` property.
/// Alternately, `spacing` can be passed as a parameter init init.
///
///     lazy var collectionView: UICollectionView = {
///         let layout: CarouselCollectionViewFlowLayout = .init(
///             itemSize: CarouselCollectionViewFlowLayoutItemSize(inset: 40, height: nil),
///             spacing: 20
///         )
///
///         let collectionView: UICollectionView = .init(
///             frame: .zero,
///             collectionViewLayout: layout
///         )
///
///         collectionView.translatesAutoresizingMaskIntoConstraints = false
///
///         collectionView.showsHorizontalScrollIndicator = false
///         collectionView.isPagingEnabled = false
///
///         collectionView.delegate = self
///         collectionView.dataSource = self
///
///         collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self))
///
///         return collectionView
///     }()
///
///     view.addSubview(collectionView)
///
///     NSLayoutConstraint.activate([
///         collectionView.heightAnchor.constraint(equalToConstant: 100),
///         collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
///         collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
///         collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
///     ])
///
open class CarouselCollectionViewFlowLayout: UICollectionViewFlowLayout {
    // MARK: Properties
    private let carouselItemSize: CarouselCollectionViewFlowLayoutItemSize?
    private let spacing: CGFloat?
    
    // MARK: Initializers
    /// Initializes `CarouselCollectionViewFlowLayout`.
    public init(
        itemSize carouselItemSize: CarouselCollectionViewFlowLayoutItemSize? = nil,
        spacing: CGFloat? = nil
    ) {
        self.carouselItemSize = carouselItemSize
        self.spacing = spacing
        
        super.init()
        
        scrollDirection = .horizontal
    }
    
    required public init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Lifecycle
    override open func prepare() {
        super.prepare()
        
        guard let collectionView else { return }
        
        checkPreconditions(collectionView: collectionView)
        setUp(collectionView: collectionView)
    }
    
    // MARK: Setup
    private func checkPreconditions(
        collectionView: UICollectionView
    ) {
        guard scrollDirection == .horizontal else {
            VCoreFatalError("`scrollDirection` must be set to `horizontal")
        }
        
#if !os(tvOS)
        guard !collectionView.isPagingEnabled else {
            VCoreFatalError("`isPagingEnabled` must be set to `false`")
        }
#endif
        
        if
            let flowDelegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout,
            delegateSupportsSizeForItem(collectionView: collectionView, flowDelegate: flowDelegate)
        {
            VCoreFatalError("`collectionView(_:layout:sizeForItemAt:)` should not be implemented")
        }
    }
    
    private func setUp(
        collectionView: UICollectionView
    ) {
        carouselItemSize.map { itemSize = $0.size(in: collectionView.bounds.size) }
        
        spacing.map { minimumLineSpacing = $0 }
        
        let inset: CGFloat = {
            if let carouselItemSize = carouselItemSize {
                return carouselItemSize.inset
            } else {
                return (collectionView.bounds.size.width - itemSize.width) / 2
            }
        }()
        sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        collectionView.decelerationRate = .fast
    }
    
    // MARK: Carousel
    override open var flipsHorizontallyInOppositeLayoutDirection: Bool {
        true
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
    override open func targetContentOffset(
        forProposedContentOffset proposedContentOffset:
        CGPoint,
        withScrollingVelocity velocity: CGPoint
    ) -> CGPoint {
        guard
            let collectionView,
            let layoutAttributes: [UICollectionViewLayoutAttributes] = layoutAttributesForElements(in: collectionView.bounds)
        else {
            return super.targetContentOffset(
                forProposedContentOffset: proposedContentOffset
            )
        }
        
        let midSide: CGFloat = collectionView.bounds.size.width / 2
        
        let proposedContentOffsetCenterOrigin: CGFloat = (proposedContentOffset.x + (proposedContentOffset.x * velocity.x)) + midSide
        
        let closest: UICollectionViewLayoutAttributes = layoutAttributes
            .sorted {
                abs($0.center.x - proposedContentOffsetCenterOrigin) <
                abs($1.center.x - proposedContentOffsetCenterOrigin)
            }
            .first ??
            UICollectionViewLayoutAttributes()
        
        let targetContentOffset: CGPoint = .init(
            x: floor(closest.center.x - midSide),
            y: proposedContentOffset.y
        )
        
        return targetContentOffset
    }
    
    // MARK: Index
    /// Calculates index of center item when `UICollectionView` finishes deceleration.
    ///
    ///     func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    ///         if let carouselFlowLayout = collectionView.collectionViewLayout as? CarouselCollectionViewFlowLayout {
    ///             print(carouselFlowLayout.indexOfCenterItem(inDeceleratedEndedScrollView: scrollView))
    ///         }
    ///     }
    ///
    public func indexOfCenterItem(
        inDeceleratedEndedScrollView scrollView: UIScrollView
    ) -> Int {
        let offset: CGFloat = scrollView.contentOffset.x
        let itemWidth: CGFloat = itemSize.width
        
        return Int(floor((offset - itemWidth / 2) / itemWidth) + 1)
    }
    
    // MARK: Helpers
    private func delegateSupportsSizeForItem(
        collectionView: UICollectionView,
        flowDelegate: UICollectionViewDelegateFlowLayout
    ) -> Bool {
        flowDelegate.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:sizeForItemAt:)))
    }
}

#endif

// MARK: - Preview
#if os(iOS)

import SwiftUI

struct CarouselCollectionViewFlowLayout_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }

    private struct ViewControllerRepresentable: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            ViewController()
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }

    private final class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
        private lazy var collectionView: UICollectionView = {
            let layout: CarouselCollectionViewFlowLayout = .init(
                itemSize: .init(inset: inset, height: nil),
                spacing: spacing
            )

            let collectionView: UICollectionView = .init(
                frame: .zero,
                collectionViewLayout: layout
            )

            collectionView.translatesAutoresizingMaskIntoConstraints = false

            collectionView.showsHorizontalScrollIndicator = false
            collectionView.isPagingEnabled = false

            collectionView.delegate = self
            collectionView.dataSource = self

            collectionView.register(
                UICollectionViewCell.self,
                forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self)
            )

            return collectionView
        }()

        private let spacing: CGFloat = 20
        private let inset: CGFloat = 40

        private var data: [UIColor] = Array(repeating: [.red, .green, .blue], count: 3).flatMap { $0 }

        override func viewDidLoad() {
            super.viewDidLoad()

            view.backgroundColor = .systemBackground

            view.addSubview(collectionView)

            NSLayoutConstraint.activate([
                collectionView.constraintHeight(to: nil, constant: 100),
                collectionView.constraintLeading(to: view),
                collectionView.constraintTrailing(to: view),
                collectionView.constraintCenterY(to: view)
            ])

            collectionView.reloadData()
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            data.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .init(describing: UICollectionViewCell.self), for: indexPath)
            cell.contentView.backgroundColor = data[indexPath.row]
            return cell
        }

        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            if let carouselFlowLayout = collectionView.collectionViewLayout as? CarouselCollectionViewFlowLayout {
                print(carouselFlowLayout.indexOfCenterItem(inDeceleratedEndedScrollView: scrollView))
            }
        }
    }
}

#endif
