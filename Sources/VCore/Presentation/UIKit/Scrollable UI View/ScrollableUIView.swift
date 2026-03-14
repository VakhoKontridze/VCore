//
//  ScrollableUIView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 2/25/22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

/// `UIView` that allows the scrolling and zooming of its contained views.
///
/// `ScrollableUIView` is a wrapper that handles subviews and constraints between `UIScrollView` and content `UIView`.
/// To modify `UIScrollView` properties, access `scrollView` members.
/// To modify container `UIView` properties, access `contentView` members.
///
///     view.addSubview(scrollableView)
///     scrollableView.contentView.addSubview(view1)
///     scrollableView.contentView.addSubview(view2)
///
///     NSLayoutConstraint.activate([
///         scrollableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
///         scrollableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
///         scrollableView.topAnchor.constraint(equalTo: view.topAnchor),
///         scrollableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
///
///         view1.heightAnchor.constraint(equalToConstant: 500),
///         view1.leadingAnchor.constraint(equalTo: scrollableView.contentView.leadingAnchor),
///         view1.trailingAnchor.constraint(equalTo: scrollableView.contentView.trailingAnchor),
///         view1.topAnchor.constraint(equalTo: scrollableView.contentView.topAnchor),
///
///         view2.heightAnchor.constraint(equalToConstant: 500),
///         view2.leadingAnchor.constraint(equalTo: scrollableView.contentView.leadingAnchor),
///         view2.trailingAnchor.constraint(equalTo: scrollableView.contentView.trailingAnchor),
///         view2.topAnchor.constraint(equalTo: view1.bottomAnchor, constant: 20),
///         view2.bottomAnchor.constraint(equalTo: scrollableView.contentView.bottomAnchor)
///     ])
///
open class ScrollableUIView: UIView {
    // MARK: Properties - Appearance
    private var scrollDirection: ScrollDirection
    
    // MARK: Properties - Subviews
    /// `UIScrollView`.
    open private(set) var scrollView: UIScrollView = {
        let scrollView: UIScrollView = .init()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    /// Container in which subviews should be added.
    open private(set) var contentView: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Initializers
    /// Initializes `ScrollableUIView`.
    public init(
        direction scrollDirection: ScrollDirection = .vertical
    ) {
        self.scrollDirection = scrollDirection
        super.init(frame: .zero)
        setUp()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
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
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).withPriority(widthConstraintPriority),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).withPriority(heightConstraintPriority),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}

#if DEBUG

#Preview {
    let scrollableView: ScrollableUIView = .init()
    scrollableView.translatesAutoresizingMaskIntoConstraints = false

    let view1: UIView = .init()
    view1.translatesAutoresizingMaskIntoConstraints = false
    view1.backgroundColor = UIColor.red

    let view2: ScrollableUIView = .init()
    view2.translatesAutoresizingMaskIntoConstraints = false
    view2.backgroundColor = UIColor.blue

    scrollableView.contentView.addSubview(view1)
    scrollableView.contentView.addSubview(view2)

    NSLayoutConstraint.activate([
        view1.heightAnchor.constraint(equalToConstant: 500),
        view1.leadingAnchor.constraint(equalTo: scrollableView.contentView.leadingAnchor),
        view1.trailingAnchor.constraint(equalTo: scrollableView.contentView.trailingAnchor),
        view1.topAnchor.constraint(equalTo: scrollableView.contentView.topAnchor),

        view2.heightAnchor.constraint(equalToConstant: 500),
        view2.leadingAnchor.constraint(equalTo: scrollableView.contentView.leadingAnchor),
        view2.trailingAnchor.constraint(equalTo: scrollableView.contentView.trailingAnchor),
        view2.topAnchor.constraint(equalTo: view1.bottomAnchor, constant: 20),
        view2.bottomAnchor.constraint(equalTo: scrollableView.contentView.bottomAnchor)
    ])

    return scrollableView
}

#endif

#endif
