//
//  ScrollableUIView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 2/25/22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Scrollable UI View
/// View that allows the scrolling and zooming of its contained views.
///
/// `ScrollableUIView` is a wrapper that handles subviews and constraints between `UIScrollView` and content `UIView`.
/// To modify `UIScrollView` properties, access `scrollView` members.
/// To modify container `UIView` properties, access `contentView` members.
///
///     view.addSubview(scrollableUIView)
///     scrollableUIView.contentView.addSubview(someView1)
///     scrollableUIView.contentView.addSubview(someView2)
///
///     NSLayoutConstraint.activate([
///         scrollableUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
///         scrollableUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
///         scrollableUIView.topAnchor.constraint(equalTo: view.topAnchor),
///         scrollableUIView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
///
///         someView1.heightAnchor.constraint(equalToConstant: 500),
///         someView1.leadingAnchor.constraint(equalTo: scrollableUIView.contentView.leadingAnchor),
///         someView1.trailingAnchor.constraint(equalTo: scrollableUIView.contentView.trailingAnchor),
///         someView1.topAnchor.constraint(equalTo: scrollableUIView.contentView.topAnchor),
///
///         someView2.heightAnchor.constraint(equalToConstant: 500),
///         someView2.leadingAnchor.constraint(equalTo: scrollableUIView.contentView.leadingAnchor),
///         someView2.trailingAnchor.constraint(equalTo: scrollableUIView.contentView.trailingAnchor),
///         someView2.topAnchor.constraint(equalTo: someView1.bottomAnchor, constant: 20),
///         someView2.bottomAnchor.constraint(equalTo: scrollableUIView.contentView.bottomAnchor)
///     ])
///
open class ScrollableUIView: UIView {
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
        
        #if os(iOS)
        view.backgroundColor = .systemBackground
        #endif
        
        return view
    }()
    
    // MARK: Properties
    private var scrollDirection: ScrollDirection
    
    // MARK: Initializers
    /// Initializes `ScrollableUIView` with `ScrollDirection`.
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
            scrollView.constraintLeading(to: self),
            scrollView.constraintTrailing(to: self),
            scrollView.constraintTop(to: self),
            scrollView.constraintBottom(to: self),
            
            contentView.constraintWidth(to: scrollView, priority: widthConstraintPriority),
            contentView.constraintHeight(to: scrollView, priority: heightConstraintPriority),
            contentView.constraintLeading(to: scrollView),
            contentView.constraintTrailing(to: scrollView),
            contentView.constraintTop(to: scrollView),
            contentView.constraintBottom(to: scrollView)
        ])
    }
}

#endif
