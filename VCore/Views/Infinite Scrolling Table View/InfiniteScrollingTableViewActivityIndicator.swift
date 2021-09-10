//
//  InfiniteScrollingTableViewActivityIndicator.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import UIKit

// MARK:- Infinite Scrolling Table View Activity Indicator
final class InfiniteScrollingTableViewActivityIndicatorView: UIView {
    // MARK: Subviews
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator: UIActivityIndicatorView = .init()
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    // MARK: Properties
    private typealias Model = InfiniteScrollingTableViewActivityIndicatorModel
    
    // MARK: Initializers
    init(in tableView: UITableView) {
        super.init(frame:
            .init(
                origin: .zero,
                size: .init(
                    width: tableView.frame.size.width,
                    height: Model.Layout.height
            )
        ))
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
}

// MARK:- Setup
private extension InfiniteScrollingTableViewActivityIndicatorView {
    func setUp() {
        addSubviews()
        setUpLayout()
        activityIndicator.startAnimating()
    }
    
    func addSubviews() {
        addSubview(activityIndicator)
    }
    
    func setUpLayout() {
        activityIndicator.center = center
    }
}
