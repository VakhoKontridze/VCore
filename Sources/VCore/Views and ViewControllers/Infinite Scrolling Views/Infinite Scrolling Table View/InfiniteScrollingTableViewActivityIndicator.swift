//
//  InfiniteScrollingTableViewActivityIndicator.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Infinite Scrolling Table View Activity Indicator
final class InfiniteScrollingTableViewActivityIndicatorView: UIView {
    // MARK: Subviews
    private lazy var activityIndicator: UIActivityIndicatorView = initActivityIndicator()
    
    // MARK: Properties
    private typealias UIModel = InfiniteScrollingTableViewActivityIndicatorModel
    
    // MARK: Initializers
    init(in tableView: UITableView) {
        super.init(frame:
            .init(
                origin: .zero,
                size: .init(
                    width: tableView.frame.size.width,
                    height: UIModel.Layout.height
            )
        ))
        setUp()
    }
    
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
