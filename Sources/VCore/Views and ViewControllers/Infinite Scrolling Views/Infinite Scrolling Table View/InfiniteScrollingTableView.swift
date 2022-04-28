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
/// When insufficient data is loaded in`UITableView`, or when pagination occurs, property is set to `.loading` and delegate method is called.
/// Network call or persistent storage fetch reqiest can be made.
/// Once finished, property must be set to either `canPaginate`, or `cannotPaginate`, depending on the existence of further data.
///
/// Two methods must be called from `UIView` or `UIViewController` to ensure proper functionality:
/// - `detectPaginationFromScrollViewDidScroll`, whitch detects pagination on scroll.
/// - `detectPaginationFromTableViewCellForRow`, which detects instance in which loaded cells do not fill up UITableViews's content. So, pagination is called.
///
open class InfiniteScrollingTableView: UITableView {
    // MARK: Properties
    /// Delegate.
    open weak var infiniteScrollingDelegate: (InfiniteScrollingTableViewDelegate & UITableViewDataSource & UIScrollViewDelegate)?
    
    /// Controls pagination state.
    /// When insufficient data is loaded in`UITableView`, or when pagination occurs, property is set to `.loading` and delegate method is called.
    /// Network call or persistent storage fetch reqiest can be made.
    /// Once finished, property must be set to either `canPaginate`, or `cannotPaginate`, depending on the existence of further data.
    open var paginationState: PaginationState = .canPaginate { didSet { setActivityIndicatorState() } }
    
    /// Offset that needs to be dragged vertically up for pagination to occur. Defaults to `20`.
    open var paginationOffset: CGFloat = 20
    
    private var isFirstLayoutSubviews: Bool = false

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

    // MARK: Detection
    /// Detects pagination on scroll.
    open func detectPaginationFromScrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.didScrollToBottom(offset: paginationOffset) else { return }

        paginate()
    }
    
    /// Detects instance in which loaded cells do not fill up UITableViews's content. So, pagination is called.
    open func detectPaginationFromTableViewCellForRow() {
        guard !contentHeightExceedsTableViewHeight else { return }
        
        paginate()
    }

    // MARK: Pagination
    private func paginate() {
        guard paginationState == .canPaginate else { return }
        
        paginationState = .loading
        infiniteScrollingDelegate?.tableViewDidScrollToBottom(sender: self)
    }

    // MARK: Activity Indicator
    private func setActivityIndicatorState() {
        switch paginationState {
        case .loading:
            guard frame.width != 0 else { return }
            tableFooterView = InfiniteScrollingTableViewActivityIndicatorView(in: self)
        
        case .canPaginate, .cannotPaginate:
            tableFooterView = nil
            reloadData()
        }
    }
}
