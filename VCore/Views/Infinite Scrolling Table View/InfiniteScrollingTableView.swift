//
//  InfiniteScrollingTableView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import UIKit

// MARK: - Infinite Scrolling Table View
/// Subclass of `UITableView` that handles infinite scrolling.
///
/// Contains property `paginationState`, controls pagination state.
/// When insufficient data is loaded in`UITableView`, or when pagination occurs, property is set to `.isLoading` and delegate method is called.
/// Network call or persistent storage fetch reqiest can be made.
/// Once finished, property must be set to either `canPaginate`, or `shouldNotPaginate`, depending on the existence of further data.
///
/// Two methods must be called from `UIView` or `UIViewController to ensure proper functionality:
/// - `detectPaginationFromScrollViewDidScroll(:_)`, whitch detects pagination on scroll.
/// - `detectPaginationFromTableViewCellForRow(:_)`, which detects instance in which loaded cells do not fill up UITableViews's content. So, pagination is called.
///
public final class InfiniteScrollingTableView: UITableView {
    // MARK: Properties
    /// Delegate.
    public weak var infiniteScrollingDelegate: (InfiniteScrollingTableViewDelegate & UITableViewDataSource & UIScrollViewDelegate)?
    
    /// Controls pagination state.
    /// When insufficient data is loaded in`UITableView`, or when pagination occurs, property is set to `.isLoading` and delegate method is called.
    /// Network call or persistent storage fetch reqiest can be made.
    /// Once finished, property must be set to either `canPaginate`, or `shouldNotPaginate`, depending on the existence of further data.
    public var paginationState: PaginationState = .canPaginate { didSet { setActivityIndicatorState() } }
    
    /// Offset that needs to be dragged vertically up for pagination to occur. Defaults to `20`.
    public var paginationOffset: CGFloat = 20
    
    // If paginationState is set to `isLoading` before UITableView's constraint are set,
    // InfiniteScrollingTableViewActivityIndicatorView won't layout properly.
    private var boundsObserver: NSKeyValueObservation?
    
    // MARK: Initializers
    public init() {
        super.init(frame: .zero, style: .plain)
        createBoundsObserver()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Detection
    /// Detects pagination on scroll.
    public func detectPaginationFromScrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.didScrollToBottom(offset: paginationOffset) else { return }

        paginate()
    }
    
    /// Detects instance in which loaded cells do not fill up UITableViews's content. So, pagination is called.
    public func detectPaginationFromTableViewCellForRow() {
        guard !contentHeightExceedsTableViewHeight else { return }
        
        paginate()
    }

    // MARK: Pagination
    private func paginate() {
        guard paginationState == .canPaginate else { return }
        
        paginationState = .isLoading
        infiniteScrollingDelegate?.tableViewDidScrollToBottom(sender: self)
    }

    // MARK: Activity Indicator
    func setActivityIndicatorState() {
        switch paginationState {
        case .isLoading:
            guard frame.width != 0 else { return }
            tableFooterView = InfiniteScrollingTableViewActivityIndicatorView(in: self)
        
        case .canPaginate, .shouldNotPaginate:
            tableFooterView = nil
            reloadData()
        }
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
}

// MARK: - Detection
extension UIScrollView {
    fileprivate func didScrollToBottom(offset: CGFloat) -> Bool {
        guard contentOffset.y > 0 else { return false }
        
        let didScrollToBottom: Bool =
            contentOffset.y + frame.size.height >=
            contentSize.height - offset
        
        return didScrollToBottom
    }
    
    fileprivate var contentHeightExceedsTableViewHeight: Bool {
        contentSize.height > frame.size.height
    }
}
