//
//  InfiniteScrollingUITableViewActivityIndicatorView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Infinite Scrolling UI Table View Activity Indicator
final class InfiniteScrollingUITableViewActivityIndicatorView: UIView {
    // MARK: Subviews
    private lazy var activityIndicator: UIActivityIndicatorView = initActivityIndicator()
    
    // MARK: Properties
    private typealias UIModel = InfiniteScrollingUITableViewActivityIndicatorViewUIModel
    
    // MARK: Initializers
    init(in tableView: UITableView) {
        super.init(
            frame: CGRect(
                origin: .zero,
                size: CGSize(
                    width: tableView.frame.size.width,
                    height: UIModel.height
                )
            )
        )
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Setup
    private func setUp() {
        addSubviews()
        setUpLayout()
        activityIndicator.startAnimating()
    }
    
    private func addSubviews() {
        addSubview(activityIndicator)
    }
    
    private func setUpLayout() {
        activityIndicator.center = center
    }
}

#endif
