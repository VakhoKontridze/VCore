//
//  ScrollableView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 2/25/22.
//

import UIKit

// MARK: - Scrollable View
/// View that allows the scrolling and zooming of its contained views.
///
/// A wrapper class that handles subviews and constraints between `UIScrollView` and content `UIView`.
/// To modify `UIScrollView` properties, access `scrollView` members.
/// To modify container `UIView` properties, access `contentView` members.
///
/// Usage Example:
///
///     view.addSubview(scrollableView)
///     scrollableView.contentView.addSubview(someView1)
///     scrollableView.contentView.addSubview(someView2)
///     scrollableView.contentView.addSubview(someView3)
///
open class ScrollableView: UIView {
    // MARK: Subviews
    /// `UIScrollView` object.
    open var scrollView: UIScrollView = {
        let scrollView: UIScrollView = .init()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    /// Container in which subviews must be added.
    open var contentView: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: Properties
    private var scrollDirection: ScrollDirection
    
    // MARK: Initializers
    /// Initializes `ScrollableView` with `ScrollDirection`.
    public init(
        direction scrollDirection: ScrollDirection
    ) {
        self.scrollDirection = scrollDirection
        super.init(frame: .zero)
        setUp()
    }
    
    required public init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Setup
    private func setUp() {
        setUpView()
        addSubviews()
        setUpLayout()
    }
    
    private func setUpView() {
        backgroundColor = .clear
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    private func setUpLayout() {
        let widthConstraintPriority: UILayoutPriority? = scrollDirection.contains(.horizontal) ? .defaultLow : nil
        let heightConstraintPriority: UILayoutPriority? = scrollDirection.contains(.vertical) ? .defaultLow : nil
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
                .withPriority(widthConstraintPriority),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
                .withPriority(heightConstraintPriority),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}

// MARK: - Helpers
extension NSLayoutConstraint {
    func withPriority(_ priority: UILayoutPriority?) -> NSLayoutConstraint {
        priority.map { self.priority = $0 }
        return self
    }
}
