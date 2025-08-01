//
//  InfiniteScrollingUITableViewActivityIndicatorView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

final class InfiniteScrollingUITableViewActivityIndicatorView: UIView {
    // MARK: Properties - Appearance
    private let appearance: InfiniteScrollingUITableViewAppearance
    
    // MARK: Properties - Subviews
    private lazy var activityIndicator: UIActivityIndicatorView = initActivityIndicator()
    
    // MARK: Initializers
    init(
        appearance: InfiniteScrollingUITableViewAppearance = .init(),
        tableView: UITableView
    ) {
        self.appearance = appearance
        
        super.init(
            frame: CGRect(
                origin: .zero,
                size: CGSize(
                    width: tableView.frame.size.width,
                    height: appearance.activityIndicatorContainerHeight
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
