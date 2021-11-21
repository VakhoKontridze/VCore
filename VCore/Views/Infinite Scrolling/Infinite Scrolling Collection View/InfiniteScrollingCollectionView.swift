//
//  InfiniteScrollingCollectionView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/21/21.
//

import UIKit

// MARK: - Infinite Scrolling Collection View
/// Subclass of `UICollectionView` that handles infinite scrolling.
///
/// Contains property `paginationState`, controls pagination state.
/// When insufficient data is loaded in`UICollectionView`, or when pagination occurs, property is set to `.isLoading` and delegate method is called.
/// Network call or persistent storage fetch reqiest can be made.
/// Once finished, property must be set to either `canPaginate`, or `shouldNotPaginate`, depending on the existence of further data.
///
/// Three methods must be called from `UIView` or `UIViewController` to ensure proper functionality:
/// - `detectPaginationFromScrollViewDidScroll`, whitch detects pagination on scroll.
/// - `detectPaginationFromCollectionViewCellForItem`, which detects instance in which loaded cells do not fill up UICollectionViews's content. So, pagination is called.
/// - `viewForSupplementaryElement`, which returns `UIActivityIndicator`.
///
public final class InfiniteScrollingCollectionView: UICollectionView {
    // MARK: Subviews
    private lazy var activityIndicator: UIActivityIndicatorView = initActivityIndicator()
    
    // MARK: Properties
    /// Delegate.
    public weak var infiniteScrollingDelegate: (InfiniteScrollingCollectionViewDelegate & UICollectionViewDataSource & UIScrollViewDelegate)?
    
    /// Controls pagination state.
    /// When insufficient data is loaded in`UICollectionView`, or when pagination occurs, property is set to `.isLoading` and delegate method is called.
    /// Network call or persistent storage fetch reqiest can be made.
    /// Once finished, property must be set to either `canPaginate`, or `shouldNotPaginate`, depending on the existence of further data.
    public var paginationState: PaginationState = .canPaginate { didSet { setActivityIndicatorState() } }
    
    /// Offset that needs to be dragged vertically up for pagination to occur. Defaults to `20`.
    public var paginationOffset: CGFloat = 20
    
    // If paginationState is set to `isLoading` before UICollectionView's constraint are set,
    // `UIActivityIndicator` won't layout properly.
    private var boundsObserver: NSKeyValueObservation?
    
    private typealias ActivityIndicaatorModel = InfiniteScrollingCollectionViewActivityIndicatorModel
    
    // MARK: Initializers
    public override init(frame: CGRect, collectionViewLayout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
        setUp()
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Setup
    private func setUp() {
        registerActivityIndicatorView()
        createBoundsObserver()
    }
    
    private func registerActivityIndicatorView() {
        register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: UICollectionReusableView.nsObjectName!
        )
        
        guard (collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection == .vertical else {
            fatalError("InfiniteScrollingCollectionView scrollDirection must be vertical")
        }
        
        (collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize = .init(
            width: bounds.width,
            height: ActivityIndicaatorModel.Layout.height
        )
    }
    
    private func createBoundsObserver() {
        boundsObserver = observe(
            \.bounds,
            options: [.new],
            changeHandler: { [weak self] (_, change) in
                guard let self = self else { return }
                
                guard
                    change.newValue?.width != 0,
                    self.paginationState == .isLoading
                else {
                    return
                }

                self.setActivityIndicatorState()
            }
        )
    }

    // MARK: Detection
    /// Detects pagination on scroll.
    public func detectPaginationFromScrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.didScrollToBottom(offset: paginationOffset) else { return }

        paginate()
    }
    
    /// Detects instance in which loaded cells do not fill up UICollectionViews's content. So, pagination is called.
    public func detectPaginationFromCollectionViewCellForItem() {
        guard !contentHeightExceedsCollectionViewHeight else { return }
        
        paginate()
    }
    
    /// Returns `UIActivityIndicator`.
    public func viewForSupplementaryElement(kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard numberOfSections <= 1 else {
            fatalError("InfiniteScrollingCollectionView doesn't support multiple sections")
        }
        
        guard kind == UICollectionView.elementKindSectionFooter else { return .init() }
        
        let footer: UICollectionReusableView = dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: UICollectionReusableView.nsObjectName!,
            for: indexPath
        )
        
        footer.addSubview(activityIndicator)
        
        activityIndicator.frame = .init(
            origin: .zero,
            size: .init(
                width: frame.size.width,
                height: ActivityIndicaatorModel.Layout.height
            )
        )
        
        return footer
    }

    // MARK: Pagination
    private func paginate() {
        guard paginationState == .canPaginate else { return }
        
        paginationState = .isLoading
        infiniteScrollingDelegate?.collectionViewDidScrollToBottom(sender: self)
    }

    // MARK: Activity Indicator
    private func setActivityIndicatorState() {
        switch paginationState {
        case .isLoading:
            guard frame.width != 0 else { return }
            activityIndicator.startAnimating()
        
        case .canPaginate, .shouldNotPaginate:
            activityIndicator.stopAnimating()
            reloadData()
        }
    }
}
