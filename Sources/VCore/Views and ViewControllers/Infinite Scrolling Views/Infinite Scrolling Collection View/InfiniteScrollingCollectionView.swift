//
//  InfiniteScrollingCollectionView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/21/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Infinite Scrolling Collection View
/// Subclass of `UICollectionView` that handles infinite scrolling.
///
/// Contains property `paginationState`, controls pagination state.
/// When insufficient data is loaded in`UICollectionView`, or when pagination occurs, property is set to `.loading` and delegate method is called.
/// Network call or persistent storage fetch reqiest can be made.
/// Once finished, property must be set to either `canPaginate`, or `cannotPaginate`, depending on the existence of further data.
///
/// Three methods must be called from `UIView` or `UIViewController` to ensure proper functionality:
/// - `detectPaginationFromScrollViewDidScroll`, whitch detects pagination on scroll.
/// - `detectPaginationFromCollectionViewCellForItem`, which detects instance in which loaded cells do not fill up UICollectionViews's content. So, pagination is called.
/// - `viewForSupplementaryElement`, which returns `UIActivityIndicator`.
///
open class InfiniteScrollingCollectionView: UICollectionView {
    // MARK: Subviews
    private lazy var activityIndicator: UIActivityIndicatorView = initActivityIndicator()
    
    // MARK: Properties
    /// Delegate.
    open weak var infiniteScrollingDelegate: (InfiniteScrollingCollectionViewDelegate & UICollectionViewDataSource & UIScrollViewDelegate)?
    
    /// Controls pagination state.
    /// When insufficient data is loaded in`UICollectionView`, or when pagination occurs, property is set to `.loading` and delegate method is called.
    /// Network call or persistent storage fetch reqiest can be made.
    /// Once finished, property must be set to either `canPaginate`, or `cannotPaginate`, depending on the existence of further data.
    open var paginationState: PaginationState = .canPaginate { didSet { setActivityIndicatorState() } }
    
    /// Offset that needs to be dragged vertically up for pagination to occur. Defaults to `20`.
    open var paginationOffset: CGFloat = 20
    
    private var isFirstLayoutSubviews: Bool = false
    
    private typealias ActivityIndicaatorModel = InfiniteScrollingCollectionViewActivityIndicatorModel
    
    // MARK: Initializers
    public override init(frame: CGRect, collectionViewLayout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
        setUp()
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Lifecycle
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if isFirstLayoutSubviews {
            isFirstLayoutSubviews = false
            
            if paginationState == .loading {
                setActivityIndicatorState()
            }
        }
    }
    
    // MARK: Setup
    private func setUp() {
        registerActivityIndicatorView()
    }
    
    private func registerActivityIndicatorView() {
        register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: .init(describing: UICollectionReusableView.self)
        )
        
        guard (collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection == .vertical else {
            fatalError("InfiniteScrollingCollectionView scrollDirection must be vertical")
        }
        
        (collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize = .init(
            width: bounds.width,
            height: ActivityIndicaatorModel.Layout.height
        )
    }

    // MARK: Detection
    /// Detects pagination on scroll.
    open func detectPaginationFromScrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.didScrollToBottom(offset: paginationOffset) else { return }

        paginate()
    }
    
    /// Detects instance in which loaded cells do not fill up UICollectionViews's content. So, pagination is called.
    open func detectPaginationFromCollectionViewCellForItem() {
        guard !contentHeightExceedsCollectionViewHeight else { return }
        
        paginate()
    }
    
    /// Returns `UIActivityIndicator`.
    open func viewForSupplementaryElement(kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard numberOfSections <= 1 else {
            fatalError("InfiniteScrollingCollectionView doesn't support multiple sections")
        }
        
        guard kind == UICollectionView.elementKindSectionFooter else { return .init() }
        
        let footer: UICollectionReusableView = dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: .init(describing: UICollectionReusableView.self),
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
        
        paginationState = .loading
        infiniteScrollingDelegate?.collectionViewDidScrollToBottom(sender: self)
    }

    // MARK: Activity Indicator
    private func setActivityIndicatorState() {
        switch paginationState {
        case .loading:
            guard frame.width != 0 else { return }
            activityIndicator.startAnimating()
        
        case .canPaginate, .cannotPaginate:
            activityIndicator.stopAnimating()
            reloadData()
        }
    }
}

#endif
